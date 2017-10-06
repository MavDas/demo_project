RSpec.describe PostsController, type: :routing do
  describe 'routing' do
    before(:each) { FactoryGirl.create(:group) }

	  it 'routes to #index' do
	    expect(get: '/groups/1/posts').to route_to('posts#index', group_id: "1")
	  end

	  it 'routes to #show' do
	    expect(get: '/groups/1/posts/1').to route_to('posts#show',group_id: "1", id: '1')
	  end

	  it 'routes to #new' do
	    expect(get: '/groups/1/posts/new').to route_to('posts#new',group_id: "1")
	  end
  end
end