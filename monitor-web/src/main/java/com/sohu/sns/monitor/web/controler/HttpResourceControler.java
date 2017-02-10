package com.sohu.sns.monitor.web.controler;

import com.sohu.sns.monitor.common.module.HttpResource;
import com.sohu.sns.monitor.common.services.HttpResourceService;
import com.sohu.sns.monitor.common.services.MqttServerAddressService;
import com.sohucs.org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.ObjectFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import scala.util.parsing.combinator.testing.Str;

import java.util.*;

/**
 * Created by yw on 2017/1/13.
 */
@Controller
public class HttpResourceControler {
    @Autowired
    HttpResourceService httpResourceService;

    @ResponseBody
    @RequestMapping(value="/getHttpResource")
    public Map getHttpResource(){
        HashMap<String,Object> map=new HashMap<String,Object>();
        map.put("data",httpResourceService.getResources());
        map.put("options","");
        map.put("files","");
        return map;
    }

    @ResponseBody
    @RequestMapping(value = "/updateResource",method = RequestMethod.POST)
    public Map updateResource(HttpResource hr){
        httpResourceService.updateResource(hr);
        Map<String,Object> map=new HashMap<String,Object>();
        ArrayList<HttpResource> list=new ArrayList<HttpResource>();
        list.add(hr);
        map.put("data",list);
        return map;
    }

    @ResponseBody
    @RequestMapping(value = "/deleteResource",method = RequestMethod.POST)
    public HttpResource  deleteResource(HttpResource hr){
        httpResourceService.deleteResource(hr);
        return new HttpResource();
    }

    @ResponseBody
    @RequestMapping(value = "/createResource",method = RequestMethod.POST)
    public  Map createResource( HttpResource hr){
        httpResourceService.createResource(hr);
        Map<String,Object> map=new HashMap<String,Object>();
        ArrayList<HttpResource> list=new ArrayList<HttpResource>();
        list.add(hr);
        map.put("data",list);
        return map;
    }

}
