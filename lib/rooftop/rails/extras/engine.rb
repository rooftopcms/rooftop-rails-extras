module Rooftop
  module Rails
    module Extras
      class Engine < ::Rails::Engine

        isolate_namespace Rooftop::Rails::Extras

        config.before_initialize do

        end

        initializer "add_helpers" do
          ActiveSupport.on_load(:action_view) do
            include Rooftop::Rails::Extras::NavigationHelper
            include Rooftop::Rails::Extras::RelatedFieldsHelper

          end
        end

       config.to_prepare do
          ::Rails.application.eager_load!
          if Rooftop::Page.page_classes.present?
            Rooftop::Page.page_classes.each do |klass|
              klass.send(:include, Rooftop::Rails::Extras::PageRedirect)
            end
          end
          if Rooftop::Nested.nested_classes.present?
            Rooftop::Nested.nested_classes.each do |klass|
              klass.send(:include, Rooftop::Rails::Extras::ResolvedChildren)
            end
          end
        end

      end
    end

  end
end
