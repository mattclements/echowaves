require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Convos", %q{
  In order to chat
  As a registered user
  I want to be able to create a convo
  } do


    scenario "registered user creates a public Convo" do
      @convo_title = "my new convo"
      @user = active_user
      login_as_user @user
      click_link "new convo"
      fill_in "convo_title", :with => @convo_title
      choose('convo_privacy_public')
      click_button("convo_submit")
      page.should have_content "Convo was successfully created."        
      click_link "nav_convos_link"
      page.should have_content @convo_title

      click_link "logout"
      click_link "nav_convos_link"
      page.should have_content @convo_title
    end

    scenario "registered user creates a private Convo" do
      @convo_title = "my new convo"
      @user = active_user
      login_as_user @user
      click_link "new convo"
      fill_in "convo_title", :with => @convo_title
      choose('convo_privacy_private')
      click_button("convo_submit")
      page.should have_content "Convo was successfully created."        
      click_link "nav_convos_link"
      page.should_not have_content @convo_title

      click_link "nav_subscriptions_link"
      page.should have_content @convo_title

      click_link "logout"
      click_link "nav_convos_link"
      page.should_not have_content @convo_title
    end


  end