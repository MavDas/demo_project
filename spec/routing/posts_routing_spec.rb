RSpec.describe PostsController, type: :routing do
  describe 'routing' do
    let!(:group) { FactoryGirl.create(:group) }

	  it 'routes to #index' do
	    expect(get: "/groups/#{group.id}/posts").to route_to('posts#index', group_id: "#{group.id}")
	  end

	  it 'routes to #show' do
	    expect(get: "/groups/#{group.id}/posts/1").to route_to('posts#show',group_id: "#{group.id}", id: '1')
	  end

	  it 'routes to #new' do
	    expect(get: "/groups/#{group.id}/posts/new").to route_to('posts#new',group_id: "#{group.id}")
	  end
  end
end