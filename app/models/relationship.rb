class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "Member"  # フォローする側の会員に所属
  belongs_to :followed, class_name: 'Member'  # フォローされる側の会員に所属
end
