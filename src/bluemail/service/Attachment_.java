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
"filename",
"content_type",
"data"
})
public class Attachment_ {

@JsonProperty("filename")
private String filename;
@JsonProperty("content_type")
private String contentType;
@JsonProperty("data")
private String data;
@JsonIgnore
private Map<String, Object> additionalProperties = new HashMap<String, Object>();

/**
*
* @return
* The filename
*/
@JsonProperty("filename")
public String getFilename() {
return filename;
}

/**
*
* @param filename
* The filename
*/
@JsonProperty("filename")
public void setFilename(String filename) {
this.filename = filename;
}

/**
*
* @return
* The contentType
*/
@JsonProperty("content_type")
public String getContentType() {
return contentType;
}

/**
*
* @param contentType
* The content_type
*/
@JsonProperty("content_type")
public void setContentType(String contentType) {
this.contentType = contentType;
}

/**
*
* @return
* The data
*/
@JsonProperty("data")
public String getData() {
return data;
}

/**
*
* @param data
* The data
*/
@JsonProperty("data")
public void setData(String data) {
this.data = data;
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