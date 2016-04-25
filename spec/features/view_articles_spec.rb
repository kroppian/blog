describe "viewing articles" do

  #
  # Helper methods
  #
  def expect_page_to_have_articles
    @articles.each do |art|
      expect(page).to have_link(art.title)
    end
  end

  def expect_articles_to_have_edit_buttons
    @articles.each do |art|
      expect(page).to have_xpath("//a[@href='#{edit_article_path(art)}']")
    end
  end

  def expect_articles_to_not_have_edit_buttons
    @articles.each do |art|
      expect(page).to have_no_xpath("//a[@href='#{edit_article_path(art)}']")
    end
  end

  def expect_articles_to_have_delete_buttons
    @articles.each do |art|
      expect(page).to have_xpath("//a[@data-method='delete' and @href='#{article_path(art)}']")
    end
  end

  def expect_articles_to_not_have_delete_buttons
    @articles.each do |art|
      expect(page).to have_no_xpath("//a[data-method='delete' and @href='#{article_path(art)}']")
    end
  end

  def expect_page_to_have_title
    expect(page).to have_css("h1", text: "The Click")
  end

  def log_in (user)
    visit '/login'
    within('form')do 
      fill_in 'Email',with: user.email
      fill_in 'Password',with: @password 
    end
    click_button 'Log in'
    expect(page).to have_current_path('/articles')
  end

  #
  # specs
  #
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

  context "when a not logged in user accesses the index" do
    it 'displays an index page with all the articles' do
      visit '/'
      expect_page_to_have_title
      expect_page_to_have_articles
    end
    it 'doesn\'t display edit or delete buttons' do
      expect_articles_to_not_have_edit_buttons
      expect_articles_to_not_have_delete_buttons
    end
  end

  context "when a non-admin user accesses the index" do 
    before do
      log_in @non_admin
      visit '/'
    end
    it 'displays an index page with all the articles for all users' do
      expect_page_to_have_title
      expect_page_to_have_articles
    end
    it 'doesn\'t display edit or delete buttons' do
      expect_articles_to_not_have_edit_buttons
      expect_articles_to_not_have_delete_buttons
    end
  end

  context "when a admin user accesses the index" do 
    before do
      log_in @admin
      visit '/'
    end
    it 'displays an index page with all the articles for all users' do
      expect_page_to_have_title
      expect_page_to_have_articles
    end
    it 'displays edit or delete buttons' do
      expect_articles_to_have_edit_buttons
      expect_articles_to_have_delete_buttons
    end
  end

  context "when the owner user accesses the index" do 
    before do
      log_in @owner
      visit '/'
    end
    it 'displays an index page with all the articles for all users' do
      expect_page_to_have_title
      expect_page_to_have_articles
    end
    it 'displays edit or delete buttons' do
      expect_articles_to_have_edit_buttons
      expect_articles_to_have_delete_buttons
    end
  end

end

