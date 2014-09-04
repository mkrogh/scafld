require "spec_helper"
require "scafld"

describe Scafld do
  let(:template) {"Hi {{name}} hope you like {{what}}"}

  it "should replace tokens" do
    result = Scafld.from_s(template)
              .replace("name", "Markus")
              .replace("what", "meat")
              .build
    expect(result).to eq("Hi Markus hope you like meat")
  end

  context "#replace" do
      let(:scafld) {Scafld.from_s "Hi {{name}}, I see your name is {{name}}"}
      it "should replace multiple" do
        result = scafld.replace("name", "Markus").build
        expect(result).to eq("Hi Markus, I see your name is Markus")
      end
  end

  context "when cleanup is disabled" do
    let(:scafld) {Scafld.from_s(template).cleanup(:off)}
    it "should leave the tokens alone" do
      result = scafld.build
      expect(result).to eq("Hi {{name}} hope you like {{what}}")
    end
  end

  context "when using cleanup" do
    let(:scafld) {Scafld.from_s(template).replace("name","Markus")}
    it "should remove unused tokens" do
      result = scafld.build
      expect(result).to eq("Hi Markus hope you like ")
    end

    it "should allow replace later" do
      scafld.build #run cleanup
      result2 = scafld.replace("what", "ruby").build
      expect(result2).to eq("Hi Markus hope you like ruby")
    end

  end

end
