﻿using System;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;
using System.Dynamic;
using System.Text;
using System.Security.Cryptography;
using System.Data.SqlClient;
using System.Data;
using System.Net.Mail;
using System.Net;
using System.Linq;
using KVConnector.Properties;
using System.Text.RegularExpressions;
using TBSeed;

//using TBUtility;

namespace KVConnector
{
    public class Util
    {        
        
        #region GetUserIdFromEmail
        public static int GetUserIdFromEmail(SeedDataAccess seedDataAccess, string email)
        {
            List<SqlParameter> parms = new List<SqlParameter>();
            parms.Add(new SqlParameter("email", email));
            string userId = seedDataAccess.ExecuteScalarAsString(SqlResource.GetUserIdFromEmail, parms);
            return (int.Parse(userId));
        }
        #endregion

        #region GetEmailFromCode
        public static string GetEmailFromCode(SeedDataAccess seedDataAccess, string code)
        {
            List<SqlParameter> parms = new List<SqlParameter>();
            parms.Add(new SqlParameter("code", code));
            string email = seedDataAccess.ExecuteScalarAsString(SqlResource.GetEmailFromCode, parms);
            return (email);
        }
        #endregion

        #region GetMd5Hash
        public static string GetMd5Hash(string input)
        {
            StringBuilder sBuilder = new StringBuilder();
            using (MD5 md5Hash = MD5.Create())
            {
                // Convert the input string to a byte array and compute the hash.
                byte[] data = md5Hash.ComputeHash(Encoding.UTF8.GetBytes(input));                
                for (int i = 0; i < data.Length; i++)
                {
                    sBuilder.Append(data[i].ToString("x2"));
                }
            }
            return sBuilder.ToString();
        }
        #endregion

        #region setError      
        public static void SetError(dynamic results, int status, string errorMessage, string details)
        {
            results.error = new ExpandoObject();
            results.error.status = status;
            results.error.message = errorMessage;
            results.error.details = details;
        }
        #endregion        

        #region SendMail   
        public static void SendMail(MailItem mailItem)
        {
            MailMessage mess = new MailMessage();
            mess.To.Add(mailItem.To);
            mess.From = new MailAddress(mailItem.From,null,Encoding.UTF8);
            mess.Subject = mailItem.Subject;
            mess.SubjectEncoding = Encoding.UTF8;
            mess.Body = mailItem.Body;
            mess.BodyEncoding = Encoding.UTF8;
            mess.IsBodyHtml = true;
            mess.Priority = MailPriority.High;
            SmtpClient client = new SmtpClient();
            client.Credentials = new NetworkCredential(mailItem.From, mailItem.Password);
            client.Port = mailItem.Port;
            client.Host = mailItem.Host;
            client.EnableSsl = true;
            client.Send(mess);
            //mess.To.Add("sagarwal@netwoven.com");
            //mess.From = new MailAddress("capitalch2@gmail.com", "Email header", System.Text.Encoding.UTF8);
            //mess.Subject = "This mail is send as test";
            //mess.SubjectEncoding = System.Text.Encoding.UTF8;
            //mess.Body = "This is Email Body";
            //mess.BodyEncoding = System.Text.Encoding.UTF8;
            //mess.IsBodyHtml = true;
            //mess.Priority = MailPriority.High;
            //SmtpClient client = new SmtpClient();
            //client.Credentials = new NetworkCredential("capitalch2@gmail.com", "su$hant123");
            //client.Port = 587;
            ////client.Port = 465;
            //client.Host = "smtp.gmail.com";
            //client.EnableSsl = true;
        }
        #endregion

        #region IsValidEmail
        public static bool IsValidEmail(string input)
        {
            Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
            Match match = regex.Match(input);
            if (match.Success)
                return true;
            else
                return false;
        }

        #endregion

        #region GetUserIdFromCode
        public static int GetUserIdFromCode(SeedDataAccess seedDataAccess, string code)
        {
            List<SqlParameter> parms = new List<SqlParameter>();
            parms.Add(new SqlParameter("code", code));
            string userId = seedDataAccess.ExecuteScalarAsString(SqlResource.GetUserIdFromCode, parms);
            return (int.Parse(userId));
        }
        #endregion

    }
}
