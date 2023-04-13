class SendMailer < ApplicationMailer
	def send_mailer(datum,email)
		@datum = datum
		mail(to: email, from: "gulshanbarwa194@gmail.com", subject: "new") do |format|
			format.html {render "send_mailer/send_mailer"}
		end
	end
end
