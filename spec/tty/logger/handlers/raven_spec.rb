# frozen_string_literal: true

require 'tty/logger/handlers/raven'

module TTY
  class Logger
    module Handlers
      RSpec.describe Raven do
        let(:logger) do
          TTY::Logger.new { |c| c.handlers = [[:raven, level: :info]] }
        end

        before { ::Raven.breadcrumbs.class.clear! }

        it 'adds breadcrumbs with the event fields' do
          logger.info('Hello', foo: :bar)

          expect(::Raven.breadcrumbs.buffer.last).to have_attributes(
            data: { foo: :bar }
          )
        end

        it 'adds breadcrumbs with the event level' do
          logger.info('Hello')

          expect(::Raven.breadcrumbs.buffer.last).to have_attributes(
            level: 'info'
          )
        end

        it 'adds breadcrumbs with the joined message' do
          logger.info('Hello', 'world')

          expect(::Raven.breadcrumbs.buffer.last).to have_attributes(
            message: 'Hello world'
          )
        end

        it 'adds breadcrumbs with the mapped filename' do
          begin
            raise 'oh no'
          rescue StandardError => e
            logger.error(e)
          end

          expect(::Raven.breadcrumbs.buffer.last).to have_attributes(
            data: { type: 'RuntimeError', value: 'oh no' }
          )
        end

        it 'has a configurable level' do
          logger.debug('Not here')

          expect(::Raven.breadcrumbs.buffer).to all(be_nil)
        end
      end
    end
  end
end
