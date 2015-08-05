module ActiveAdmin
  module Translate

    # Adds a builder method `translate_attributes_table_for` to build a
    # table with translations for a model that has been localized with
    # Globalize.
    #
    class TranslateAttributesTable < ::ActiveAdmin::Views::AttributesTable

      builder_method :translate_attributes_table_for

      def row(attr, available_locales = ::I18n.available_locales, &block)
        available_locales.each_with_index do |locale, index|
          @table << tr do
            if index == 0
              th :rowspan => available_locales.length do
                header_content_for(attr)
              end
            end
            @collection.each do |record|
              ::I18n.with_locale locale do
                td do
                  locale
                end
                td do
                  content_for(record, block || attr)
                end
              end
            end
          end
        end
      end

      protected

      def default_id_for_prefix
        'attributes_table'
      end

      def default_class_name
        'attributes_table'
      end

    end
  end
end
