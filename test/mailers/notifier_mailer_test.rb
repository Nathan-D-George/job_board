require "test_helper"

class NotifierMailerTest < ActionMailer::TestCase

  test "new email" do
    enlistments = enlistments(:one)

    email = NotifierMailer.with(enlistment: enlistment).new_email

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal 'nathan.intern@bitcube.tech', email.from
    assert_equal 'limeynd@gmail.com',          email.to
    assert_equal "You are invited for an interview!", email.subject
    
    assert_match enlistment.name, email.html_part.body.encoded
    assert_match enlistment.name, email.text_part.body.encoded
    assert_match enlistment.user_id, email.html_part.encoded
    assert_match enlistment.user_id, email.text_part.encoded
    assert_match enlistment.job_id, email.html_part.encoded
    assert_match enlistment.job_id, email.text_part.encoded
  end
end
