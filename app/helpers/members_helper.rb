module MembersHelper
  def is_checked? member_checkeds, user
    member_checkeds.include? user.id.to_s
  end
end
