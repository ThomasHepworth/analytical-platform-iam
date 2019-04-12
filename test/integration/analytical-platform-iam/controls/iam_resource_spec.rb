# frozen_string_literal: true

iam_user_name = 'kitchen@cooking.test.com'
iam_name = 'kitchen'

control 'iam_resources' do
  describe aws_iam_user(username: iam_user_name) do
    it { should exist }
  end

  describe aws_iam_group(group_name: iam_name) do
    it { should exist }
    its('users') { should include iam_user_name }
  end

  describe aws_iam_policy(policy_name: "assume-role-#{iam_name}") do
    it { should exist }
    its('attached_groups') { should include iam_name }
  end

  describe aws_iam_role(role_name: iam_name) do
    it { should exist }
  end
end
