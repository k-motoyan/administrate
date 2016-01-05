require "rails_helper"

RSpec.describe Administrate::ApplicationHelper do
  describe "#display_resource_name" do
    it "defaults to the plural of the model name" do
      displayed = display_resource_name(:customer)

      expect(displayed).to eq("Customers")
    end

    it "handles string arguments" do
      displayed = display_resource_name("customer")

      expect(displayed).to eq("Customers")
    end

    it "handles plural arguments" do
      displayed = display_resource_name(:customers)

      expect(displayed).to eq("Customers")
    end

    context "when translations are defined" do
      it "uses the plural of the defined translation" do
        translations = {
          activerecord: {
            models: {
              customer: {
                one: "User",
                other: "Users",
              },
            },
          },
        }

        with_translations(:en, translations) do
          displayed = display_resource_name(:customer)

          expect(displayed).to eq("Users")
        end
      end
    end
  end

  describe "#index_path_method_name" do
    let(:namespace) { "admin" }

    subject { index_path_method_name(namespace, resource) }

    context "when resource is uncountable" do
      let(:resource) { "information" }
      it { is_expected.to eq "#{namespace}_#{resource}_index_path" }
    end

    context "when resource is countable" do
      let(:resource) { "blog" }
      it { is_expected.to eq "#{namespace}_#{resource}_path" }
    end
  end
end
