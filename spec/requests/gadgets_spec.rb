require 'rails_helper'

describe 'Gadgets' do

  before(:each) do
    @user ||= FactoryGirl.create(:user)
    post_via_redirect user_session_path, 'user[email]' => @user.email, 'user[password]' => 'password'
  end

  it 'creates a gadget and renders list' do
    get '/gadgets/new'
    expect(response).to render_template(:new)

    post '/gadgets', gadget: {name: 'iphone', description: 'My black phone'}
    expect(response).to redirect_to(gadgets_path)
    follow_redirect!

    expect(response).to render_template(:index_list)
    expect(response.body).to include('iphone')
    expect(response.body).to include('My black phone')
  end

  it 'switches list styles' do
    get '/gadgets'
    expect(response).to render_template(:index_list)
    get '/gadgets', style: 'cover'
    expect(response).to render_template(:index_cover)
    get '/gadgets', style: 'list'
    expect(response).to render_template(:index_list)
  end

  context 'images' do
    let!(:gadget) { FactoryGirl.create(:gadget, user: @user) }
    it 'attaches image to a gadget' do
      get '/gadgets'
      expect(response.body).to include('Add image...')
      get "/gadgets/#{gadget.id}/images/new"
      expect(response).to render_template(:new)
      post "/gadgets/#{gadget.id}/images",
           image: {source: fixture_file_upload(File.join(Rails.root, '/spec/fixtures/files/image.jpg'), 'image/jpeg')}
      expect(response).to redirect_to(gadgets_path)
      follow_redirect!

      expect(response).to render_template(:index_list)
      expect(response.body).to include('image.jpg')
    end

    it 'show stub image for a gadget without images in cover view' do
      get '/gadgets', style: 'cover'
      expect(response.body).to include('no-image.jpg')
    end
  end

end