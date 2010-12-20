require 'lib/symbol_replacer'

describe SymbolReplacer, "Replaces globals with their value" do
  describe "#replace" do
    context "when input is a blank string" do
      it "should return an empty string" do
        SymbolReplacer.new("").replace.should == ""
      end
    end

    context "when $my_var is nil" do
      before { $my_var = nil }

      context "and $my_var is in the input" do
        let(:string) { '$my_var' }
        it "should return $my_var unchanged" do
          SymbolReplacer.new(string).replace.should == '$my_var'
        end
      end
    end

    context "when $my_var has a value" do
      before { $my_var = "replacement" }
      context "and $my_var is in the input" do
        let(:string) { '$my_var' }
        it "should replace $my_var with it's value" do
          SymbolReplacer.new(string).replace.should == 'replacement'
        end
      end

      context "and $another_var has a value" do
        before { $another_var = "my value" }
        context "and both defined global variables are in the input" do
          let(:string) { '$my_var $another_var' }
          it "should replace both variables with their values" do
            SymbolReplacer.new(string).replace.should == 'replacement my value'
          end
        end

        context "and both defined globals are mixed in with additional text" do
          let(:string) { 'some text here $another_var then $my_var' }
          it "should replace both variables with their values" do
            SymbolReplacer.new(string).replace.should == 'some text here my value then replacement' 
          end
        end

        context "and the text contains the both defined globals names mashed together" do
          let(:string) { '$another_var$my_var' }
          it "should replace both" do
            SymbolReplacer.new(string).replace.should == 'my valuereplacement'
          end
        end

        context "and the globals are referenced on different lines" do
          let(:string) { "some text here\n $another_var\n then $my_var" }
          it "should replace both variables with their values" do
            SymbolReplacer.new(string).replace.should == "some text here\n my value\n then replacement"
          end
        end
      end
    end
  end
end
