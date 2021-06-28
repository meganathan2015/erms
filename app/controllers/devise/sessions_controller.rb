class Devise::SessionsController < DeviseController
    prepend_before_action :verify_signed_out_user, only: :destroy


    # GET /resource/sign_in
    def new
        self.resource = resource_class.new(sign_in_params)
        clean_up_passwords(resource)
        yield resource if block_given?
        # respond_with(resource, serialize_options(resource))
    end

    # POST /resource/sign_in
    def create
        user = User.find_for_authentication(email: sign_in_params[:email])

        if user.valid_password?(sign_in_params[:password]) && user.role == sign_in_params[:role]
            user.remember_me = sign_in_params[:remember_me]
            sign_in_and_redirect(user, event: :authentication)
        end
    end

    # DELETE /resource/sign_out
    def destroy
        signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
        set_flash_message! :notice, :signed_out if signed_out
        yield if block_given?
        respond_to_on_destroy

    end

    protected

    def sign_in_params
        devise_parameter_sanitizer.sanitize(:sign_in)
    end

    private

    # Check if there is no signed in user before doing the sign out.
    #
    # If there is no signed in user, it will set the flash message and redirect
    # to the after_sign_out path.
    def verify_signed_out_user
        if all_signed_out?
        set_flash_message! :notice, :already_signed_out

        respond_to_on_destroy
        end
    end

    def all_signed_out?
        users = Devise.mappings.keys.map { |s| warden.user(scope: s, run_callbacks: false) }

        users.all?(&:blank?)
    end

    def respond_to_on_destroy
        # We actually need to hardcode this as Rails default responder doesn't
        # support returning empty response on GET request
        respond_to do |format|
        format.all { head :no_content }
        format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name) }
        end
    end

end