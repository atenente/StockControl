require 'rails_helper'

RSpec.describe User, type: :model do
  let(:company) { create(:company) }
  let(:admin) { create(:user, role: :admin, company: company) }
  let(:user_user) { create(:user, role: :user, company: company) }

  describe 'validations' do
    context 'when the role is admin' do
      it 'Is valid without a company_id' do
        expect(admin).to be_valid
      end

      it 'With an invalid company_id' do
        invalid_user = build(:user, role: :admin, company_id: 'invalid_token')
        expect(invalid_user).not_to be_valid
      end
    end

    context 'when the role is user' do
      it 'Is valid without a company_id' do
        expect(user_user).to be_valid
      end

      it 'With an invalid company_id' do
        invalid_user = build(:user, role: :user, company_id: 'invalid_token')
        expect(invalid_user).not_to be_valid
      end
    end
  end

  describe '#validate_company_id' do
    context 'when the role is admin' do
      it 'does not require a valid company_id' do
        expect(admin.valid?).to be true
      end

      it 'requires a valid company_id' do
        invalid_user = build(:user, role: :admin, company_id: 'invalid_token')
        expect(invalid_user.valid?).to be false
      end
    end

    context 'when the role is user' do
      it 'does not require a valid company_id' do
        expect(user_user.valid?).to be true
      end

      it 'requires a valid company_id' do
        invalid_user = build(:user, role: :user, company_id: 'invalid_token')
        expect(invalid_user.valid?).to be false
      end
    end
  end

  describe 'associations' do
    it "With admin: belongs to a company" do
      expect(admin.company).to eq(company)
    end

    it "With user: belongs to a company" do
      expect(user_user.company).to eq(company)
    end
  end
end
