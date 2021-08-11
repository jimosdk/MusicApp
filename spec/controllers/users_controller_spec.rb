require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe "Get #new" do
        it "renders the new template" do
            get :new,{}
            expect(response).to render_template("new")
        end
    end

    describe "Post #create" do 
        context "with invalid params" do 
            it "renders the new template" do 
                post :create, params: {user: {name: 'John',email:'john@mail',password:'123'}}
                expect(response).to render_template("new")
            end
            it "validates the presence of the user's email" do
                post :create ,params:{user: {name: 'John',password:'123456'}}
                expect(response).to render_template("new")
                expect(flash[:errors].first).to eq("Email can't be blank")
            end

            it "validates the presence of the user's password" do
                post :create, params: {user: {name: 'John',email:'john@mail'}}
                expect(response).to render_template("new")
                expect(flash[:errors].first).to eq("Password digest can't be blank")
            end

            it "validates the presence of the user's name" do 
                post :create, params: {user: {email:'john@mail',password:'123456'}}
                expect(response).to render_template("new")
                expect(flash[:errors].first).to eq("Name can't be blank")
            end

            it "validates that the password is at least 6 characters long" do
                post :create, params: {user: {name: 'John',email:'john@mail',password:'123'}}
                expect(response).to render_template("new")
                expect(flash[:errors].first).to eq("Password is too short (minimum is 6 characters)")
            end
        end

        context "with valid params" do 
            it "sends an authentication mail" do 
                expect_any_instance_of(UserMailer).to receive(:authentication_mail)
                post :create, params: {user: {name: 'John',email:'john@mail',password:'123456'}}
                #expect(ActionMailer::Base.deliveries.count).to eq(1)
                expect(response).to render_template("new")
                expect(flash[:errors]).to eq(["Authentication mail has been sent ,please follow the link provided in the mail to complete the authentication process"])
                
            end
        end
    end
end
