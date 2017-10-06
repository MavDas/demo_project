RSpec.describe GroupsController, type: :routing do
  describe 'routing' do
 	  let!(:group){ FactoryGirl.create(:group) }

    it 'routes to #index' do
      expect(get: groups_path).to route_to('groups#index')
    end

    it 'routes to #show' do
      expect(get: group_path(group.id)).to route_to('groups#show', id: "#{group.id}")
    end

    it 'routes to #new' do
      expect(get: new_group_path).to route_to('groups#new')
    end
  end
end