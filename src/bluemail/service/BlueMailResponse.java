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
"email",
"plan_id",
"link"
})
public class BlueMailResponse {

@JsonProperty("email")
private String email;
@JsonProperty("plan_id")
private String planId;
@JsonProperty("link")
private List<Link> link = new ArrayList<Link>();
@JsonIgnore
private Map<String, Object> additionalProperties = new HashMap<String, Object>();

/**
*
* @return
* The email
*/
@JsonProperty("email")
public String getEmail() {
return email;
}

/**
*
* @param email
* The email
*/
@JsonProperty("email")
public void setEmail(String email) {
this.email = email;
}

/**
*
* @return
* The planId
*/
@JsonProperty("plan_id")
public String getPlanId() {
return planId;
}

/**
*
* @param planId
* The plan_id
*/
@JsonProperty("plan_id")
public void setPlanId(String planId) {
this.planId = planId;
}

/**
*
* @return
* The link
*/
@JsonProperty("link")
public List<Link> getLink() {
return link;
}

/**
*
* @param link
* The link
*/
@JsonProperty("link")
public void setLink(List<Link> link) {
this.link = link;
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