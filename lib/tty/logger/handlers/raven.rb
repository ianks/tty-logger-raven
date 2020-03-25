# frozen_string_literal: true

require 'tty/logger/handlers/base'

module TTY
  class Logger
    module Handlers
      class Raven
        include Base

        attr_reader :config, :level

        def initialize(
          output: $stderr, formatter: nil, config: nil, level: nil, styles: {}
        )
          @config = config
          @level = level || @config.level
          @mutex = Mutex.new
        end

        # @api public
        def call(event)
          @mutex.lock

          data = {}

          event.metadata.each do |meta|
            case meta
            when :file
              data[:path] = format_filepath(event)
            end
          end

          unless event.backtrace.empty?
            data[:type] = event.message.first&.class&.name
            data[:value] = event.message.first&.message
          end

          data.merge!(event.fields) unless event.fields.empty?

          ::Raven.breadcrumbs.record do |crumb|
            crumb.level = event.metadata[:level].to_s
            crumb.category = 'logger'
            crumb.message = event.message.join(' ')
            crumb.timestamp = event.metadata[:time].to_i
            crumb.type = event.backtrace.empty? ? 'default' : 'error'
            crumb.data = data
          end
        ensure
          @mutex.unlock
        end
      end
    end
  end
end
