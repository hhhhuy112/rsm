module MembersHelper
  def is_checked? member_checkeds, user
    member_checkeds.include? user.id.to_s
  end

  def get_role_member
    Member.roles.map{|key, value| [t("member.roles.#{key}"), key]}
  end
end
