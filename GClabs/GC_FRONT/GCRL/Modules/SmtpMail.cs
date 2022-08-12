using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.ComponentModel;

namespace GCRL.Modules
{
    internal class SmtpMail
    {
        internal static bool SendFormMail(MailAddress sender, List<MailAddress> receivers, List<MailAddress> ccs, List<MailAddress> bccs, string subject, string bodyContents)
        {
            bool rtnResult = false;

            try
            {
                Properties.Settings settings = Properties.Settings.Default;

                using (MailMessage mailMessage = new MailMessage() {
                    From = sender,
                    Subject = subject,
                    SubjectEncoding = Encoding.UTF8,
                    IsBodyHtml = true,
                    Body = bodyContents,
                    BodyEncoding = Encoding.UTF8,
                    Priority = MailPriority.Normal
                })
                {
                    foreach (var item in receivers)
                    {
                        mailMessage.To.Add(item);
                    }

                    if (ccs != null) {
                        foreach (var item in ccs)
                        {
                            mailMessage.CC.Add(item);
                        }
                    }

                    if (bccs != null)
                    {
                        foreach (var item in bccs)
                        {
                            mailMessage.Bcc.Add(item);
                        }
                    }

                    using (SmtpClient smtpClient = new SmtpClient()
                    {
                        //Credentials = new NetworkCredential(settings.SmtpAccount, settings.SmtpPassword),
                        Host = settings.SmtpHost,   // 
                        Port = settings.SmtpPort,   // 25 || 465 || 587
                        EnableSsl = settings.SmtpSSL,
                        DeliveryMethod = SmtpDeliveryMethod.Network
                    })
                    {
                        smtpClient.Send(mailMessage);

                        rtnResult = true;
                    }
                }

            }
            catch { }


            return rtnResult;
        }
    }
}