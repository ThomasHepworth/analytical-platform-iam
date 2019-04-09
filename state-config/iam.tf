resource "aws_iam_group" "tf_state" {
  name = "${var.tf_state_name}"
}

resource "aws_iam_group_policy_attachment" "tf_state_group_attachement_s3" {
  group      = "${aws_iam_group.tf_state.id}"
  policy_arn = "${aws_iam_policy.state_bucket.arn}"
}

resource "aws_iam_group_policy_attachment" "tf_state_group_attachement_dynamo" {
  group      = "${aws_iam_group.tf_state.id}"
  policy_arn = "${aws_iam_policy.state_lock.arn}"
}
