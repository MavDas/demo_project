RSpec.describe PostsController, type: :routing do
  describe 'routing' do
    let!(:group) { FactoryGirl.create(:group) }

	  it 'routes to #index' do
	    expect(get: group_posts_path(group.id)).to route_to('posts#index', group_id: "#{group.id}")
	  end

	  it 'routes to #show' do
	    expect(get: group_post_path(group.id, 1)).to route_to('posts#show',group_id: "#{group.id}", id: '1')
	  end

	  it 'routes to #new' do
	    expect(get: new_group_post_path(group.id)).to route_to('posts#new',group_id: "#{group.id}")
	  end
  end
end