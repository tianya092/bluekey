package bluemail.service;

import java.util.HashMap;
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
"attachment"
})
public class Attachment {

@JsonProperty("attachment")
private Attachment_ attachment;
@JsonIgnore
private Map<String, Object> additionalProperties = new HashMap<String, Object>();

/**
*
* @return
* The attachment
*/
@JsonProperty("attachment")
public Attachment_ getAttachment() {
return attachment;
}

/**
*
* @param attachment
* The attachment
*/
@JsonProperty("attachment")
public void setAttachment(Attachment_ attachment) {
this.attachment = attachment;
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