require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  describe "tags#create action" do
    before do
      @note = Note.create(title: 'First', content: 'This is a note.')
      post :create, params: { tag: { name: 'Crazy' }, note_id: @note.id }
    end

    it "should return 200 status-code" do
      expect(response).to be_success
    end

    it "should successfully create and save a new tag in our database" do
      expect(@note.tags.count).to eq(1)
    end
  end

  describe "tags#create action validations" do
    before do
      @note = Note.create(title: 'First', content: 'This is a note.')
      post :create, params: { tag: { name: '' }, note_id: @note.id }
    end

    it "should properly deal with validation error" do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "should return error json on validation error" do
      json = JSON.parse(response.body)
      expect(json['errors']['name'][0]).to eq("can't be blank")
    end
  end

  describe "tags#destroy action" do
    before do
      note = Note.create(title: 'First', content: 'This is a note.')
      @tag = Tag.create(name: 'This is a tag', note_id: note.id)
      delete :destroy, params: { note_id: note.id, id: @tag.id }
    end

    it "should return 200 status-code" do
      expect(response).to be_success
    end

    it "should be removed from the database" do
      deleted_tag = Tag.find_by_id(@tag.id)
      expect(deleted_tag).to eq nil
    end
  end
end
