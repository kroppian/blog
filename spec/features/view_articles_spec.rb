describe "viewing an article" do

  context 'user not logged in' do

    it "displays index page" do

      visit '/'
      expect(page).to have_content 'The Click'

    end

  end

end
