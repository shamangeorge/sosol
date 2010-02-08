class UserController < ApplicationController
  layout 'site'
  
  def signout
    reset_session
    redirect_to :controller => :welcome, :action => "index"
  end
  
  def account
    if @current_user
      @identifiers = @current_user.user_identifiers
    end    
  end
  
  def signin
    
  end
  
  def developer
    if !@current_user.developer
      redirect_to dashboard_url
      return
    end
    @boards = Board.find(:all)
  end
  
#  def index      
#   if @current_user.admin
#     @users = User.find(:all)
#   else
#     render :file => 'public/403.html', :status => '403'
#   end
#  end
  
#  def ask_language_prefs
#    @langs = @current_user.language_prefs 
# end

#  def set_language_prefs
#    @current_user.language_prefs =  params[:languages]
#    @current_user.save
#    
#    redirect_to :controller => :user, :action => "dashboard"
#  end  
  
  def dashboard
    #don't let someone who isn't signed in go to the dashboard
    if @current_user == nil
      redirect_to :controller => "user", :action => "signin"
      return
    end
    #below selects publications to show in standard user data section of dashboard
    #@publications = Publication.find_all_by_owner_id(@current_user.id, :conditions => "owner_type = 'User' AND owner_id = creator_id AND parent_id is null", :include => :identifiers)
    @publications = Publication.find_all_by_owner_id(@current_user.id, :conditions => {:owner_type => 'User', :creator_id => @current_user.id, :parent_id => nil }, :include => :identifiers, :order => "updated_at DESC")
    #below selects publications current user is responsible for finalizing to show in board section of dashboard
    @board_final_pubs = Publication.find_all_by_owner_id(@current_user.id, :conditions => "owner_type = 'User' AND status = 'finalizing'", :include => :identifiers, :order => "updated_at DESC")
       
    #or do we want to use the creator id?
    #@publications = Publication.find_all_by_creator_id(@current_user.id, :include => :identifiers)
    
    @events = Event.find(:all, :order => "created_at DESC",
                         :include => [:owner, :target])[0..25]
    
  end
  
  

  def update_personal
  #TODO don't let any bozo change this data
    if @current_user.id != params[:id].to_i()
      flash[:warning] = "Invalid Access."

      redirect_to ( dashboard_url ) #just send them back to their own dashboard...side effects here?
      return
    end
    
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to( dashboard_url) } #TODO redirect to ? dashboard or account
        format.xml  { head :ok }
      else
        format.html { render :action => "account" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
end
