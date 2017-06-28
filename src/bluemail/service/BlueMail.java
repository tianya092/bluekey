package bluemail.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("org.jsonschema2pojo")
@JsonPropertyOrder({
"contact",
"recipients",
"cc",
"bcc",
"subject",
"message",
"attachments"
})
public class BlueMail {

@JsonProperty("contact")
private String contact;
@JsonProperty("recipients")
private List<Recipient> recipients = new ArrayList<Recipient>();
@JsonProperty("cc")
private List<Cc> cc = new ArrayList<Cc>();
@JsonProperty("bcc")
private List<Bcc> bcc = new ArrayList<Bcc>();
@JsonProperty("subject")
private String subject;
@JsonProperty("message")
private String message;
@JsonProperty("attachments")
private List<Attachment> attachments = new ArrayList<Attachment>();
@JsonIgnore
private Map<String, Object> additionalProperties = new HashMap<String, Object>();

/**
*
* @return
* The contact
*/
@JsonProperty("contact")
public String getContact() {
return contact;
}

/**
*
* @param contact
* The contact
*/
@JsonProperty("contact")
public void setContact(String contact) {
this.contact = contact;
}

/**
*
* @return
* The recipients
*/
@JsonProperty("recipients")
public List<Recipient> getRecipients() {
return recipients;
}

/**
*
* @param recipients
* The recipients
*/
@JsonProperty("recipients")
public void setRecipients(List<Recipient> recipients) {
this.recipients = recipients;
}

/**
*
* @return
* The cc
*/
@JsonProperty("cc")
public List<Cc> getCc() {
return cc;
}

/**
*
* @param cc
* The cc
*/
@JsonProperty("cc")
public void setCc(List<Cc> cc) {
this.cc = cc;
}

/**
*
* @return
* The bcc
*/
@JsonProperty("bcc")
public List<Bcc> getBcc() {
return bcc;
}

/**
*
* @param bcc
* The bcc
*/
@JsonProperty("bcc")
public void setBcc(List<Bcc> bcc) {
this.bcc = bcc;
}

/**
*
* @return
* The subject
*/
@JsonProperty("subject")
public String getSubject() {
return subject;
}

/**
*
* @param subject
* The subject
*/
@JsonProperty("subject")
public void setSubject(String subject) {
this.subject = subject;
}

/**
*
* @return
* The message
*/
@JsonProperty("message")
public String getMessage() {
return message;
}

/**
*
* @param message
* The message
*/
@JsonProperty("message")
public void setMessage(String message) {
this.message = message;
}

/**
*
* @return
* The attachments
*/
@JsonProperty("attachments")
public List<Attachment> getAttachments() {
return attachments;
}

/**
*
* @param attachments
* The attachments
*/
@JsonProperty("attachments")
public void setAttachments(List<Attachment> attachments) {
this.attachments = attachments;
}

@JsonAnyGetter
public Map<String, Object> getAdditionalProperties() {
return this.additionalProperties;
}

@JsonAnySetter
public void setAdditionalProperty(String name, Object value) {
this.additionalProperties.put(name, value);
}

}