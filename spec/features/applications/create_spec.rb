require 'rails_helper'

RSpec.describe 'application creation' do
    before(:each) do
      @application_1 = Application.create!(applicant_name: "Bob", street_address: "123 Home St", city: "Denver", state: "CO", zip_code: "80238", description: "I love animals")
    end

    describe 'the application new' do
      it 'renders the new form' do
        visit "/applications/new"
        
        expect(page).to have_content("New Application")
        expect(find('form')).to have_content("Applicant name")
        expect(find('form')).to have_content("Street address")
        expect(find('form')).to have_content("City")
        expect(find('form')).to have_content("State")
        expect(find('form')).to have_content("Zip code")
        expect(find('form')).to have_content("Description")
      end
    end

    describe 'the application create' do
      context 'given valid data' do
        it "creates the new application and redirects to the application's show page" do
          visit "/applications/new"
          
          fill_in 'Applicant name', with: 'Bob'
          fill_in 'Street address', with: '123 Main St'
          fill_in 'City', with: 'Denver'
          fill_in 'State', with: 'CO'
          fill_in 'Zip code', with: '80238'
          fill_in 'Description', with: 'I love animals'
          click_button "Submit"
         
          expect(page).to have_current_path("/applications/#{Application.last.id}")
          # expect(page).to have_content('Bob')
        end
      end

      context 'given invalid data' do
        it 're-renders the new form' do
          visit "/applications/new"
          click_button "Submit"
          save_and_open_page
          expect(page).to have_current_path("/applications/new")
          expect(page).to have_content("Error: All sections must be filled out")
        end
      end
    end
end