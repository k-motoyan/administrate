module Administrate
  module ApplicationHelper
    def render_field(field, locals = {})
      locals.merge!(field: field)
      render locals: locals, partial: field.to_partial_path
    end

    def display_resource_name(resource_name)
      resource_name.
        to_s.
        classify.
        constantize.
        model_name.
        human(
          count: 0,
          default: resource_name.to_s.pluralize.titleize,
        )
    end

    def index_path_method_name(namespace, resource)
      if uncountable_noun?(resource)
        "#{namespace}_#{resource}_index_path"
      else
        "#{namespace}_#{resource}_path"
      end
    end

    private

    def uncountable_noun?(str)
      ActiveSupport::Inflector.inflections.uncountable.include?(str.to_s)
    end
  end
end
