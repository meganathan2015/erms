class UserManagement < ApplicationRecord
    mount_uploader :pan_details, AadharDetailsUploader # Tells rails to use this uploader for this model.
    mount_uploader :aadhar_details, EducationDetailsUploader # Tells rails to use this uploader for this model.
    # mount_uploader :education_details, ExperienceDetailsUploader # Tells rails to use this uploader for this model.
    # mount_uploader :experience_details, PanDetailsUploader # Tells rails to use this uploader for this model.
    mount_uploader :profile_pictures, ProfilePicturesUploader # Tells rails to use this uploader for this model.
    has_secure_password
    paginates_per 10

end
