﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace KVConnector.Properties {
    using System;
    
    
    /// <summary>
    ///   A strongly-typed resource class, for looking up localized strings, etc.
    /// </summary>
    // This class was auto-generated by the StronglyTypedResourceBuilder
    // class via a tool like ResGen or Visual Studio.
    // To add or remove a member, edit your .ResX file then rerun ResGen
    // with the /str option, or rebuild your VS project.
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Resources.Tools.StronglyTypedResourceBuilder", "4.0.0.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    internal class SqlResource {
        
        private static global::System.Resources.ResourceManager resourceMan;
        
        private static global::System.Globalization.CultureInfo resourceCulture;
        
        [global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal SqlResource() {
        }
        
        /// <summary>
        ///   Returns the cached ResourceManager instance used by this class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Resources.ResourceManager ResourceManager {
            get {
                if (object.ReferenceEquals(resourceMan, null)) {
                    global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("KVConnector.Properties.SqlResource", typeof(SqlResource).Assembly);
                    resourceMan = temp;
                }
                return resourceMan;
            }
        }
        
        /// <summary>
        ///   Overrides the current thread's CurrentUICulture property for all
        ///   resource lookups using this strongly typed resource class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Globalization.CultureInfo Culture {
            get {
                return resourceCulture;
            }
            set {
                resourceCulture = value;
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to update UserMaster set PwdHash = @newPwdHash where email = @email and PwdHash = @oldPwdHash.
        /// </summary>
        internal static string ChangePasswordHash {
            get {
                return ResourceManager.GetString("ChangePasswordHash", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to delete from CreditCards where id = @id.
        /// </summary>
        internal static string DeleteCreditCard {
            get {
                return ResourceManager.GetString("DeleteCreditCard", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to select id, cardName,cardNumber, expiryDate, isDefault
        ///	from CreditCards 
        ///		where UserId = @userId;.
        /// </summary>
        internal static string GetAllCreditCards {
            get {
                return ResourceManager.GetString("GetAllCreditCards", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to select id,address1,a.zip,street,city, isDefault,
        ///	defaultSalesTaxPerc = (select StringValue from Setup where MKey = &apos;DefaultSalesTax&apos;),
        ///	defaultShippingCharges=(select StringValue from Setup where MKey = &apos;DefaultShippingCharges&apos;),
        ///	b.salesTaxPerc, b.shippingCharges
        ///	from ShippingAddresses  a left join TaxNShipping b
        ///			on a.zip = b.zip
        ///				where UserId=@userId;.
        /// </summary>
        internal static string GetAllShippingAddresses {
            get {
                return ResourceManager.GetString("GetAllShippingAddresses", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to select id, cardName,cardNumber,expiryDate
        ///	from CreditCards
        ///		where UserId = @userId
        ///			and IsDefault = 1;
        ///select id, address1,a.zip,street,city,
        ///	defaultSalesTaxPerc=(select StringValue from Setup where MKey = &apos;DefaultSalesTaxPerc&apos;),
        ///	defaultShippingCharges=(select StringValue from Setup where MKey = &apos;DefaultShippingCharges&apos;),
        ///	b.salesTaxPerc, b.shippingCharges
        ///	from ShippingAddresses a left join TaxNShipping b
        ///			on a.zip = b.zip
        ///				where UserId=@userId and IsDefault = 1;
        ///
        ///select prevBalanceW [rest of string was truncated]&quot;;.
        /// </summary>
        internal static string GetApproveArtifacts {
            get {
                return ResourceManager.GetString("GetApproveArtifacts", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to select id, item, price, packing, availableQty from OfferMaster;.
        /// </summary>
        internal static string GetCurrentOffer {
            get {
                return ResourceManager.GetString("GetCurrentOffer", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to select id,cardName,cardNumber,ExpiryDate
        ///	from CreditCards
        ///		where UserId = @userId
        ///			and IsDefault = 1;.
        /// </summary>
        internal static string GetDefaultCreditCard {
            get {
                return ResourceManager.GetString("GetDefaultCreditCard", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to select id, address1,a.zip,street,city,
        ///	defaultSalesTaxPerc=(select StringValue from Setup where MKey = &apos;DefaultSalesTaxPerc&apos;),
        ///	defaultShippingCharges=(select StringValue from Setup where MKey = &apos;DefaultShippingCharges&apos;),
        ///	b.salesTax, b.shippingCharges
        ///	from ShippingAddresses a left join TaxNShipping b
        ///			on a.zip = b.zip
        ///				where UserId=@userId and IsDefault = 1;.
        /// </summary>
        internal static string GetDefaultShippingAddress {
            get {
                return ResourceManager.GetString("GetDefaultShippingAddress", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to select id, Role,PwdHash from UserMaster where Email = @email;.
        /// </summary>
        internal static string GetHashAndRole {
            get {
                return ResourceManager.GetString("GetHashAndRole", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to select max(IntValue) from Setup where MKey = &apos;MaxOrderNumber&apos;.
        /// </summary>
        internal static string GetMaxOrderNumber {
            get {
                return ResourceManager.GetString("GetMaxOrderNumber", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to select a.id, address1,zip,street,city
        ///	from OrderImpDetails a join ShippingAddresses b
        ///		on a.addressId = b.id		
        ///	where orderId = @orderId
        ///select a.id, cardName,cardNumber
        ///	from OrderImpDetails a join CreditCards b
        ///		on a.CreditCardId = b.id
        ///	where orderId = @orderId.
        /// </summary>
        internal static string GetOrderDetails {
            get {
                return ResourceManager.GetString("GetOrderDetails", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to select id,mDate,orderNo,descr,isDelivered,invoice, amount, salesTaxWine, salesTaxAddl
        ///	, shippingWine, shippingAddl, totalPriceWine, totalPriceAddl
        ///	from orderMaster 
        ///		where UserId=@userId;.
        /// </summary>
        internal static string GetOrderHeaders {
            get {
                return ResourceManager.GetString("GetOrderHeaders", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to select b.id, firstName,lastName, phone, birthDay, mailingAddress1
        ///	, mailingAddress2, mailingCity, mailingState, mailingZip
        ///	from userMaster a join userProfiles b
        ///		on a.Id = b.UserId
        ///			where email = @email;.
        /// </summary>
        internal static string GetProfile {
            get {
                return ResourceManager.GetString("GetProfile", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to select PwdHash from UserMaster where email = @email;.
        /// </summary>
        internal static string GetPwdHash {
            get {
                return ResourceManager.GetString("GetPwdHash", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to select b.id,address1,zip,street,city, isDefault
        ///	from UserMaster a join ShippingAddresses b
        ///		on a.Id = b.UserId
        ///			where email = @email;.
        /// </summary>
        internal static string GetShippingAddress {
            get {
                return ResourceManager.GetString("GetShippingAddress", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to select MAX(Id) from UserMaster where Email = @email;.
        /// </summary>
        internal static string GetUserIdFromEmail {
            get {
                return ResourceManager.GetString("GetUserIdFromEmail", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to declare @cnt int;
        ///declare @id int;
        ///insert into CreditCards (CardName,UserId,CardNumber,ExpiryDate)
        ///	values(@cardName,@userId,@cardNumber,@expiryDate);
        ///	SELECT @id = CAST(scope_identity() AS int);
        ///	select @cnt = count(*) from CreditCards
        ///	where userId = @userId;
        ///if(@cnt = 1)
        ///	update CreditCards set IsDefault = 1
        ///		where id = @id;
        ///select(@id);.
        /// </summary>
        internal static string InsertCreditCard {
            get {
                return ResourceManager.GetString("InsertCreditCard", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to select 0 from UserMaster where Email = @email and PwdHash = @oldPwdHash;.
        /// </summary>
        internal static string IsEmailAndHashExist {
            get {
                return ResourceManager.GetString("IsEmailAndHashExist", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to select 0 from UserMaster where Email = @email;.
        /// </summary>
        internal static string IsEmailExist {
            get {
                return ResourceManager.GetString("IsEmailExist", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to update UserMaster set PwdHash = @newPwdHash where email = @email;.
        /// </summary>
        internal static string NewPasswordHash {
            get {
                return ResourceManager.GetString("NewPasswordHash", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to update CreditCards
        ///	set IsDefault = 0
        ///			where UserId=@userId;
        ///update CreditCards
        ///	set IsDefault = 1
        ///		where Id = @cardId;.
        /// </summary>
        internal static string SetDefaultCreditCard {
            get {
                return ResourceManager.GetString("SetDefaultCreditCard", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to update Setup set IntValue = @value where MKey = &apos;MaxOrderNumber&apos;.
        /// </summary>
        internal static string SetMaxOrderNumber {
            get {
                return ResourceManager.GetString("SetMaxOrderNumber", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to update ShippingAddresses
        ///	set Address1 = @address1,
        ///	City = @city,
        ///	Zip = @zip,
        ///	Street = @street,
        ///	IsDefault = @isDefault
        ///	where Id = @id;.
        /// </summary>
        internal static string UpdateAddress {
            get {
                return ResourceManager.GetString("UpdateAddress", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to update UserProfiles 
        ///	set FirstName = @firstName,
        ///	LastName = @lastName,
        ///	Phone = @phone,
        ///	Birthday = @birthDay,
        ///	MailingAddress1 = @mailingAddress1,
        ///	MailingAddress2 = @mailingAddress2,
        ///	MailingCity = @mailingCity,
        ///	MailingState = @mailingState,
        ///	MailingZip = @mailingZip
        ///	where Id = @id;.
        /// </summary>
        internal static string UpdateProfile {
            get {
                return ResourceManager.GetString("UpdateProfile", resourceCulture);
            }
        }
    }
}
