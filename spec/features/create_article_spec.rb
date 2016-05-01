describe "viewing articles" do
 
  def log_in (user)
    visit '/login'
    within('form')do 
      fill_in 'Email',with: user.email
      fill_in 'Password',with: @password 
    end
    click_button 'Log in'
    expect(page).to have_current_path('/articles')
  end 

  before do 

    # TODO is there a way to skip this declaration?
    @articles = []
    10.times {@articles.push(create(:article))} 
    @password = 'terriblepassword'
    @non_admin = create(:user,
      user_type: 0, 
      password: @password, 
      password_confirmation: @password)
    @admin = create(:user,
      user_type: 1, 
      password: @password, 
      password_confirmation: @password)
    @owner = create(:user,
      user_type: 2, 
      password: @password, 
      password_confirmation: @password)

  end

  context 'when a non logged in user accesses index' do
    it 'displays no new article button' do 
      visit '/'
      expect(page).to have_no_link('New Article')
    end
  end   

  context 'when a non-admin accesses index' do
    it 'displays no new article button' do 
      log_in @non_admin
      visit '/'
      expect(page).to have_no_link('New Article')
    end
  end   

  context 'when an admin tries to create an article' do 

    before do
      log_in @admin
      visit '/'
      @title = 'A Head of Five Countrysides'
      @text = 'It wasn\'t the worst of times, it wasn\'t the best of times'
    end

    it 'displays a new article button on the index' do
      expect(page).to have_link('New Article')
    end
   
    it 'allows the user to create a new article' do 
      click_link 'New Article'  
      within('form') do 
        fill_in 'Title', with: @title
        fill_in 'Text', with: @text
        click_button('Create Article')
      end
      expect(page).to have_text(@title)
      expect(page).to have_text(@text)
    end
  end

  context 'when the owner tries to create an article' do 
    # TODO complete me
    it 'displays a new article button on the index' do
      log_in @owner
      visit '/'
      expect(page).to have_link('New Article')
    end
  end

end
