require "spec_helper"
require "scafld"

describe Scafld do
  let(:template) {"Hi {{name}} hope you like {{what}}"}
  let(:multi_template) {"Hi {{name}}, I see your name is {{name}}"}

  it "should replace tokens" do
    result = Scafld.from_s(template)
              .replace("name", "Markus")
              .replace("what", "meat")
              .build
    expect(result).to eq("Hi Markus hope you like meat")
  end

  describe "#tokens_left?" do
    let(:scafld) {Scafld.from_s("With {{token}}")}
    context "when there are tokens left" do
      subject {scafld.tokens_left?}
      it {is_expected.to eq(true)}
    end
    context "when there are no tokens left" do
      subject {scafld.replace("token","").tokens_left?}
      it {is_expected.to eq(false)}
    end
  end

  context "#replace" do
      let(:scafld) {Scafld.from_s multi_template}
      it "should replace multiple" do
        result = scafld.replace("name", "Markus").build
        expect(result).to eq("Hi Markus, I see your name is Markus")
      end
  end

  context "#replace_once" do
      let(:scafld) {Scafld.from_s multi_template}
      it "should replace only firs occurence" do
        result1 = scafld.replace_once("name", "Markus").build
        expect(result1).to eq("Hi Markus, I see your name is ")
        result2 = scafld.replace_once("name", "Peter").build
        expect(result2).to eq("Hi Markus, I see your name is Peter")
      end
  end

  context "when cleanup is disabled" do
    let(:scafld) {Scafld.from_s(template).cleanup(:off)}
    it "should leave the tokens alone" do
      result = scafld.build
      expect(result).to eq("Hi {{name}} hope you like {{what}}")
    end
  end

  context "when disabling tokens" do 
    let(:scafld) {Scafld.from_s("Hi is this normal?").tokens(:off)}
    it "should be able to replace normal text" do
      result = scafld.replace("Hi", "Hello").build
      expect(result).to eq("Hello is this normal?")
    end

    it "should not run cleanup" do
      result = scafld.build
      expect(result).to eq("Hi is this normal?")
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
