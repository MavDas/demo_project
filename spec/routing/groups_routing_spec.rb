RSpec.describe GroupsController, type: :routing do
  describe 'routing' do
 	  before(:each) { FactoryGirl.create(:group) }

    it 'routes to #index' do
      expect(get: '/groups').to route_to('groups#index')
    end

    it 'routes to #show' do
      expect(get: '/groups/1').to route_to('groups#show', id: '1')
    end

    it 'routes to #new' do
      expect(get: '/groups/new').to route_to('groups#new')
    end
  end
end