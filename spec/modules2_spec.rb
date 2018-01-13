require 'spec_helper'
require_relative '../modules2'

RSpec.describe Download do
  describe "print_details" do
    let (:download) { Download.new(333, "someone") }

    it "contains the class name" do
      expect(download.print_details).to include(described_class.to_s)
    end

    it "contains the file_id" do
      expect(download.print_details).to include(download.file_id.to_s)
    end

    it "contains the time" do
      expect(download.print_details).to include(download.time.to_s)
    end

    it "shows a reasonable time" do
      expect(download.time).to be_within(1).of(Time.now)
    end
  end
end