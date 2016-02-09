require 'rails_helper'

RSpec.describe RequestsController, type: :controller do
  let(:request) { FactoryGirl.create(:request) }


  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
    it "instantiates a new request object and sets it to @request" do
      get :new
      expect(assigns(:request)).to be_a_new(Request)
    end
  end

  describe "#create" do
    context "with valid attributes" do
      def valid_request
        post :create, request: {name: "Valid Name",
                                email: "stan@stan.io",
                                department: "Sales",
                                message: "Please fix."}
      end
      it "creates a record in the database" do
        request_count_before = Request.count
        valid_request
        request_count_after = Request.count
        expect(request_count_after - request_count_before).to eq(1)
      end
      it "redirects to the request show page" do
        valid_request
        expect(response).to redirect_to(request_path(Request.last))
        
      end
      # it "sets a notice flash message" do
      #   valid_request
      #   expect(flash[:notice]).to be 
      # end
    end
    context "with invalid attributes" do
      def invalid_request
        post :create, request: {department: "Sales",
                                message: "Please fix."}
      end
      it "doesn't create a record in the database" do
        request_count_before = Request.count
        invalid_request
        request_count_after = Request.count
        expect(request_count_after - request_count_before).to eq(0)
      end
      it "renders the new template" do 
        invalid_request
        expect(response).to render_template(:new)      
      end
      # it "sets an alert flash message" do
      #   invalid_request
      #   expect(flash[:alert]).to be 
      # end
    end
  end

  describe "#edit" do
    before do
      # WHEN:
      get :edit, id: request
    end
    it "renders the edit template" do
      expect(response).to render_template(:edit)
    end
    it "finds the request by id and sets it to @request instance variable" do
      expect(assigns(:request)).to eq(request)
    end
  end

  describe "#udpate" do
    context "with valid attributes" do
      before do
        patch :update, id: request, request: {name: "Valid Name",
                                              email: "stan1@stan.io",
                                              department: "Marketing",
                                              message: "Please work."}
      end
      it "updates the records with new parameter(s)" do
        expect(request.reload.name).to eq("Valid Name")
      end
      it "redirects to the request show page" do
        expect(response).to redirect_to(request)      
      end
      # it "sets a flash message" do
      #   expect(flash[:notice]).to be
      # end

    end
    context "with invalid attributes" do
      def update
        patch :update, id: request, request: { name: "",
                                                email: "",
                                                department: "Marketing",
                                                message: "Please work."}
      end
      it "doesn't update the record" do 
        name_before = request.name
        update
        expect(request.reload.name).to eq(name_before)
      end
      it "renders the edit template" do
        update
        expect(response).to render_template(:edit)      
      end
      # it "sets a flash alert message" do
      #   expect(flash[:alert]).to be
      # end

    end  
  end

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
    it "fetches all records and assigns them to @requests" do 
      r  = FactoryGirl.create(:request)
      r1 = FactoryGirl.create(:request)
      get :index
      expect(assigns(:requests)).to eq([r1, r])
    end
  end

  describe "#destroy" do
    let!(:request) { FactoryGirl.create(:request) }
    def delete_request 
      delete :destroy, id: request
    end
    it "removes the request from the database" do
      expect { delete_request }.to change { Request.count }.by(-1)
      # campaign
      # before_count = Campaigns.count
      # delete :destroy, id: campaign
      # after_count = Campaigns.count
      # expect(before_count - after_count).eq_to (1)
    end
    it "redirects to the request index page" do
      delete_request 
      expect(response).to redirect_to(requests_path)
    end
    # it "Sets a flash message" do
    #   delete_request 
    #   expect(flash[:notice]).to be
    # end
  end
end
