require "spec_helper"

describe DataMigrate::Config do
  it "sets default data_migrations_path path", :no_override do
    expect(DataMigrate.config.data_migrations_path).to eq "db/data/"
  end

  it "sets default data_template_path path", :no_override do
    expect(DataMigrate.config.data_template_path).to eq DataMigrate::Config::DEFAULT_DATA_TEMPLATE_PATH
  end

  describe "data migration path configured" do
    subject { DataMigrate.config.data_migrations_path }
    before do
      @before = DataMigrate.config.data_migrations_path
      DataMigrate.configure do |config|
        config.data_migrations_path = "db/awesome/"
      end
    end

    after do
      DataMigrate.configure do |config|
        config.data_migrations_path = @before
      end
    end

    it "equals the custom data migration path" do
      is_expected.to eq "db/awesome/"
    end
  end

  describe "data template path configured" do
    subject { DataMigrate.config.data_template_path }

    before do
      @before = DataMigrate.config.data_template_path
      DataMigrate.configure do |config|
        config.data_template_path = data_template_path
      end
    end

    let(:data_template_path) { "lib/awesome/templates/data_migration.rb" }

    after do
      DataMigrate.configure do |config|
        config.data_template_path = @before
      end
    end

    it "equals the custom data template path" do
      is_expected.to eq data_template_path
    end
  end
end
