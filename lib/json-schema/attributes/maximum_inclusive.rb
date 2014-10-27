require 'json-schema/attribute'

module JSON
  class Schema
    class MaximumInclusiveAttribute < Attribute
      def self.validate(current_schema, data, fragments, processor, validator, options = {})
        return unless data.is_a?(Numeric)

        if (current_schema.schema['maximumCanEqual'] == false ? data >= current_schema.schema['maximum'] : data > current_schema.schema['maximum'])
          message = "The property '#{build_fragment(fragments)}' did not have a maximum value of #{current_schema.schema['maximum']}, "
          message += current_schema.schema['exclusiveMaximum'] ? 'exclusively' : 'inclusively'
          validation_error(processor, message, fragments, current_schema, self, options[:record_errors])
        end
      end
    end
  end
end
