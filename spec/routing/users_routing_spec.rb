RSpec.describe UsersController, type: :routing do
  describe 'routing' do

	  it 'routes to #index' do
	    expect(get: users_path).to route_to('users#index')
	  end

	  it 'routes to #show' do
	    expect(get: user_path("1")).to route_to('users#show', id: '1')
	  end

	  it 'routes to #new' do
	    expect(get: new_user_path).to route_to('users#new')
	  end
	 
	  it 'routes to #update via PUT' do
	    expect(put: user_path(1)).to route_to('users#update', id: '1')
	  end
	  
	  it 'routes to #update via PATCH' do
	    expect(patch: user_path(1)).to route_to('users#update', id: '1')
	  end
  end
end