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
        ///   Looks up a localized string similar to declare @isDefault bit;
        ///select @isDefault = isDefault 
        ///	from PaymentMethods 
        ///		where id = @id;
        ///if(@isDefault = 1)
        ///	Update t
        ///		Set t.isDefault = 1
        ///		From
        ///		(
        ///			Select Top 1 isDefault
        ///			From PaymentMethods
        ///			Where UserId = @userId
        ///		) t;
        ///delete from PaymentMethods where id = @id;.
        /// </summary>
        internal static string DeletePaymentMethod {
            get {
                return ResourceManager.GetString("DeletePaymentMethod", resourceCulture);
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
        ///   Looks up a localized string similar to select countryId, countryName, isoCode,requiresZip from Countries order by countryName; select smartyStreetApiKey = (select stringValue from setup where MKey = &apos;SmartyStreetApiKey&apos;)
        ///	, smartyStreetAuthId = (select smartyStreetApiKey = stringValue from setup where MKey = &apos;SmartyStreetAuthId&apos;)
        ///	, smartyStreetAuthToken = (select smartyStreetApiKey = stringValue from setup where MKey = &apos;SmartyStreetAuthToken&apos;);.
        /// </summary>
        internal static string GetAllMasters {
            get {
                return ResourceManager.GetString("GetAllMasters", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to select id, cardName,ccFirstName,ccLastName,ccType,ccNumber=SUBSTRING(ccNumber,1,4) + &apos; XXXX XXXX &apos; + SUBSTRING(ccNumber,(LEN(ccNumber) - 3), 4),
        ///	ccExpiryMonth,ccExpiryYear,ccSecurityCode,name,phone,street1,street2,city,state,zip,country,isoCode,isDefault
        ///	from PaymentMethods 
        ///		where UserId = @userId;.
        /// </summary>
        internal static string GetAllPaymentMethods {
            get {
                return ResourceManager.GetString("GetAllPaymentMethods", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to select id,co,code,name,phone,street1,street2,city,state,zip,country,isoCode, isDefault, phone
        ///from ShippingAddresses	
        ///	where UserId=@userId;.
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
        ///select id, name,phone,co,street1,street2,city,state,a.zip, country,isoCode,
        ///	defaultSalesTaxPerc=(select StringValue from Setup where MKey = &apos;DefaultSalesTaxPerc&apos;),
        ///	defaultShippingCharges=(select StringValue from Setup where MKey = &apos;DefaultShippingCharges&apos;),
        ///	b.salesTaxPerc, b.shippingCharges
        ///	from ShippingAddresses a left join TaxNShipping b
        ///			on a.zip = b.zip
        ///				where UserId=@userId and  [rest of string was truncated]&quot;;.
        /// </summary>
        internal static string GetApproveArtifacts {
            get {
                return ResourceManager.GetString("GetApproveArtifacts", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to select id, item,tastingNotes,descr,imageUrl, price, packing, availableQty from OfferMaster;.
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
        ///   Looks up a localized string similar to select id, address1,a.zip,state,city,
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
        ///   Looks up a localized string similar to select id, Role,PwdHash 
        ///	from UserMaster 
        ///		where Email = @email;
        ///select adminPwdHash = stringValue
        ///	from Setup
        ///		where MKey = &apos;adminPwdHash&apos;;
        ///select adminIp = stringValue
        ///	from Setup
        ///		where MKey = &apos;adminIp&apos;;.
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
        ///   Looks up a localized string similar to select a.id, item, packing, orderQty, wishList,a.price
        ///	from OrderDetails a join OfferMaster b
        ///		on a.offerId = b.id
        ///			where orderId = @orderId;
        ///select a.id, street1,zip,state,city
        ///	from OrderImpDetails a join ShippingAddresses b
        ///		on a.addressId = b.id		
        ///	where orderId = @orderId;
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
        ///   Looks up a localized string similar to select id, firstName,lastName, phone, convert(varchar(10), birthDay, 120) as birthDay, mailingAddress1
        ///	, mailingAddress2, mailingCity, mailingState, mailingZip, mailingCountry
        ///	from UserProfiles where userId = @userId;.
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
        ///   Looks up a localized string similar to --declare @zip varchar(100);
        ///--declare @bottles int;
        ///--select @zip = &apos;a&apos;;
        ///--select @bottles = 10;
        ///select shipping = 20, salesTaxPerc = 8.5 
        ///	where @zip like&apos;%&apos; and @bottles &gt; 0;.
        /// </summary>
        internal static string GetShippingSalesTaxPerc {
            get {
                return ResourceManager.GetString("GetShippingSalesTaxPerc", resourceCulture);
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
        ///   Looks up a localized string similar to declare @cnt int;
        ///declare @id int;
        ///select @cnt = count(*) from PaymentMethods
        ///	where userId = @userId;;
        ///
        ///if(@isDefault = 1)
        ///	update PaymentMethods set isDefault = 0
        ///		where userId = @userId;
        ///
        ///if(@cnt = 0)
        ///	select @IsDefault = 1;
        ///
        ///insert into PaymentMethods (cardName,ccFirstName,ccLastName,ccType,ccNumber,ccExpiryMonth,ccExpiryYear,ccSecurityCode,name,street1,street2,city,state,zip,country,isoCode,phone,isDefault,userId)
        ///	values(@cardName,@ccFirstName,@ccLastName,@ccType,@ccNumber,@ccExpiryMonth [rest of string was truncated]&quot;;.
        /// </summary>
        internal static string InsertPaymentMethod {
            get {
                return ResourceManager.GetString("InsertPaymentMethod", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to --insert
        ///if @isDefault is null
        ///	select @isDefault = 0;
        ///
        ///if @isDefault = 1
        ///begin
        ///	update ShippingAddresses
        ///		set IsDefault = 0
        ///			where UserId = @userId;
        ///end
        ///if not exists(select 0 from ShippingAddresses where UserId = @userId)
        ///	select @isDefault = 1;
        ///
        ///insert into ShippingAddresses(Code,Name,Street1,Street2,City,State,Zip,Country,Phone,ISOCode,IsDefault,UserId)
        ///	values(@code,@name,@street1,@street2,@city,@state,@zip,@country,@phone,@isoCode,@isDefault,@userID);.
        /// </summary>
        internal static string InsertShippingAddress {
            get {
                return ResourceManager.GetString("InsertShippingAddress", resourceCulture);
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
        ///   Looks up a localized string similar to update PaymentMethods
        ///	set IsDefault = 0
        ///			where UserId=@userId;
        ///update PaymentMethods
        ///	set IsDefault = 1
        ///		where Id = @id;.
        /// </summary>
        internal static string SetDefaultPaymentMethod {
            get {
                return ResourceManager.GetString("SetDefaultPaymentMethod", resourceCulture);
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
        ///   Looks up a localized string similar to update UserProfiles 
        ///	set FirstName = @firstName,
        ///	LastName = @lastName,
        ///	Phone = @phone,
        ///	Birthday = @birthDay,
        ///	MailingAddress1 = @mailingAddress1,
        ///	MailingAddress2 = @mailingAddress2,
        ///	MailingCity = @mailingCity,
        ///	MailingState = @mailingState,
        ///	MailingZip = @mailingZip, MailingCountry=@mailingCountry
        ///	where Id = @id;.
        /// </summary>
        internal static string UpdateProfile {
            get {
                return ResourceManager.GetString("UpdateProfile", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to DECLARE @cnt int;
        ///select @cnt = count(*) from shippingAddresses where UserId = @userId;
        ///if(@cnt=1)
        ///	begin
        ///		select @isDefault = 1;
        ///	end
        ///else
        ///	begin
        ///		if @isDefault = 1
        ///			begin
        ///				update ShippingAddresses
        ///					set IsDefault = 0
        ///						where UserId = @userId;
        ///			end
        ///	end
        ///
        ///
        ///update ShippingAddresses
        ///	set Code=@code,
        ///	Name=@name,
        ///	street1=@street1,
        ///	street2=@street2,
        ///	city=@city,state=@state,zip=@zip,country=@country,
        ///	phone=@phone,
        ///	ISOCode=@isoCode,
        ///	IsDefault=@isDefault
        ///	where Id =  [rest of string was truncated]&quot;;.
        /// </summary>
        internal static string UpdateShippingAddress {
            get {
                return ResourceManager.GetString("UpdateShippingAddress", resourceCulture);
            }
        }
    }
}
