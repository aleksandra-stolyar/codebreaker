require_relative '../spec_helper'

module Codebreaker
  describe Game do
    subject(:game) {Game.new}

    context "#initialize" do
      it "has secret code" do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end

      it "has 4 items in secret code" do
        expect(game.secret_code.length).to be(4)
      end

      it "includes numbers from 1 to 6 in secret code" do
        expect(game.secret_code.join).to match(/^[1-6]{4}/) 
      end

    end  

    context "#check" do
      context "when 1234" do
        before {game.instance_variable_set(:@secret_code, [1, 2, 3, 4])}
        it "returns ++++" do
          expect(game.check("1234")).to eq("++++")
        end
        it "returns ----" do
          expect(game.check("4321")).to eq("----")
        end
        it "returns +-" do
          expect(game.check("1145")).to eq("+-")
        end
        it "returns +-" do
          expect(game.check("2536")).to eq("+-")
        end
        it "returns ++-" do
          expect(game.check("1245")).to eq("++-")
        end
      end  

      context "when 1224" do
        before(:each) {game.instance_variable_set(:@secret_code, [1, 2, 2, 4])}
        it "returns --" do
          expect(game.check("2562")).to eq("--")
        end
        it "returns" do
          expect(game.check("6666")).to eq("")
        end
        it "returns" do
          expect(game.check("6664")).to eq("+")
        end
        it "returns" do
          expect(game.check("2666")).to eq("-")
        end
      end

      context "when 2114" do
        before(:each) {game.instance_variable_set(:@secret_code, [2, 1, 1, 4])}
        it "returns --" do
          expect(game.check("1134")).to eq("++-")
        end
        it "returns" do
          expect(game.check("5134")).to eq("++")
        end
        it "returns" do
          expect(game.check("1234")).to eq("+--")
        end
        it "returns" do
          expect(game.check("1243")).to eq("---")
        end
        it "returns" do
          expect(game.check("1111")).to eq("++")
        end
      end

      context "when 4214" do
        before(:each) {game.instance_variable_set(:@secret_code, [4, 2, 1, 4])}
        it "returns ++-" do
          expect(game.check("1234")).to eq("++-")
        end
      end

      context "#hint" do
        before {game.instance_variable_set(:@secret_code, [5, 3, 2, 4])}
        it "shows only one number from code" do
          allow(game).to receive(:rand).and_return(3)
          expect(game.hint).to eq("***4")
        end

        it "changes availability of hint from true to false" do
          expect {game.hint}.to change{ game.has_hint }.to(false)
        end
      end

    end
  end
end
