
    

  

<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="chrome=1">
        <title>examples/js/swfobject.js at master from igrigorik's em-websocket - GitHub</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub" />
    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub" />

    <link href="https://assets2.github.com/stylesheets/bundle_common.css?fcea8a71e43a6abea9b38ae62a9eeb7e84f5652a" media="screen" rel="stylesheet" type="text/css" />
<link href="https://assets1.github.com/stylesheets/bundle_github.css?fcea8a71e43a6abea9b38ae62a9eeb7e84f5652a" media="screen" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
      if (typeof console == "undefined" || typeof console.log == "undefined")
        console = { log: function() {} }
    </script>
    <script type="text/javascript" charset="utf-8">
      var GitHub = {}
      var github_user = null
      
    </script>
    <script src="https://assets3.github.com/javascripts/jquery/jquery-1.4.2.min.js?fcea8a71e43a6abea9b38ae62a9eeb7e84f5652a" type="text/javascript"></script>
    <script src="https://assets0.github.com/javascripts/bundle_common.js?fcea8a71e43a6abea9b38ae62a9eeb7e84f5652a" type="text/javascript"></script>
<script src="https://assets0.github.com/javascripts/bundle_github.js?fcea8a71e43a6abea9b38ae62a9eeb7e84f5652a" type="text/javascript"></script>


        <script type="text/javascript" charset="utf-8">
      GitHub.spy({
        repo: "igrigorik/em-websocket"
      })
    </script>

    
  
    
  

  <link href="https://github.com/igrigorik/em-websocket/commits/master.atom" rel="alternate" title="Recent Commits to em-websocket:master" type="application/atom+xml" />

        <meta name="description" content="EventMachine based WebSocket server" />
    <script type="text/javascript">
      GitHub.nameWithOwner = GitHub.nameWithOwner || "igrigorik/em-websocket";
      GitHub.currentRef = 'master';
      GitHub.commitSHA = "cdedd7bd5c43e25fd0b30236889bc131b5cbe495";
      GitHub.currentPath = 'examples/js/swfobject.js';
      GitHub.masterBranch = "master";

      
    </script>
  

            <script type="text/javascript">
      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-3769691-2']);
      _gaq.push(['_trackPageview']);
      (function() {
        var ga = document.createElement('script');
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        ga.setAttribute('async', 'true');
        document.documentElement.firstChild.appendChild(ga);
      })();
    </script>

          <script type="text/javascript">
      var mpq = [];
      mpq.push(["init", "65fde2abd433eae3b32b38b7ebd2f37e"]);
      (function() {
      var mp = document.createElement("script"); mp.type = "text/javascript"; mp.async = true;
      mp.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') + "//api.mixpanel.com/site_media/js/api/mixpanel.js";
      var s = document.getElementsByTagName("script")[0]; s.parentNode.insertBefore(mp, s);
      })();
      </script>

  </head>

  

  <body class="logged_out page-blob">
    

    

    

    

    

    <div class="subnavd" id="main">
      <div id="header" class="true">
        
          <a class="logo boring" href="https://github.com">
            <img src="/images/modules/header/logov3.png?changed" class="default" alt="github" />
            <![if !IE]>
            <img src="/images/modules/header/logov3-hover.png" class="hover" alt="github" />
            <![endif]>
          </a>
        
        
        <div class="topsearch">
  
    <ul class="nav logged_out">
      <li class="pricing"><a href="/plans">Pricing and Signup</a></li>
      <li class="explore"><a href="/explore">Explore GitHub</a></li>
      <li class="features"><a href="/features">Features</a></li>
      <li class="blog"><a href="/blog">Blog</a></li>
      <li class="login"><a href="/login?return_to=https://github.com/igrigorik/em-websocket/blob/master/examples/js/swfobject.js">Login</a></li>
    </ul>
  
</div>

      </div>

      
      
        
    <div class="site">
      <div class="pagehead repohead vis-public   ">

      

      <div class="title-actions-bar">
        <h1>
          <a href="/igrigorik">igrigorik</a> / <strong><a href="https://github.com/igrigorik/em-websocket">em-websocket</a></strong>
          
          
        </h1>

        
    <ul class="actions">
      

      
        <li class="for-owner" style="display:none"><a href="https://github.com/igrigorik/em-websocket/admin" class="minibutton btn-admin "><span><span class="icon"></span>Admin</span></a></li>
        <li>
          <a href="/igrigorik/em-websocket/toggle_watch" class="minibutton btn-watch " id="watch_button" onclick="var f = document.createElement('form'); f.style.display = 'none'; this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href;var s = document.createElement('input'); s.setAttribute('type', 'hidden'); s.setAttribute('name', 'authenticity_token'); s.setAttribute('value', 'ba41504442878ffdb5ad00e716b7d565fbb4dca8'); f.appendChild(s);f.submit();return false;" style="display:none"><span><span class="icon"></span>Watch</span></a>
          <a href="/igrigorik/em-websocket/toggle_watch" class="minibutton btn-watch " id="unwatch_button" onclick="var f = document.createElement('form'); f.style.display = 'none'; this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href;var s = document.createElement('input'); s.setAttribute('type', 'hidden'); s.setAttribute('name', 'authenticity_token'); s.setAttribute('value', 'ba41504442878ffdb5ad00e716b7d565fbb4dca8'); f.appendChild(s);f.submit();return false;" style="display:none"><span><span class="icon"></span>Unwatch</span></a>
        </li>
        
          
            <li class="for-notforked" style="display:none"><a href="/igrigorik/em-websocket/fork" class="minibutton btn-fork " id="fork_button" onclick="var f = document.createElement('form'); f.style.display = 'none'; this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href;var s = document.createElement('input'); s.setAttribute('type', 'hidden'); s.setAttribute('name', 'authenticity_token'); s.setAttribute('value', 'ba41504442878ffdb5ad00e716b7d565fbb4dca8'); f.appendChild(s);f.submit();return false;"><span><span class="icon"></span>Fork</span></a></li>
            <li class="for-hasfork" style="display:none"><a href="#" class="minibutton btn-fork " id="your_fork_button"><span><span class="icon"></span>Your Fork</span></a></li>
          

          
        
      
      
      <li class="repostats">
        <ul class="repo-stats">
          <li class="watchers"><a href="/igrigorik/em-websocket/watchers" title="Watchers" class="tooltipped downwards">365</a></li>
          <li class="forks"><a href="/igrigorik/em-websocket/network" title="Forks" class="tooltipped downwards">20</a></li>
        </ul>
      </li>
    </ul>

      </div>

        
  <ul class="tabs">
    <li><a href="https://github.com/igrigorik/em-websocket" class="selected" highlight="repo_source">Source</a></li>
    <li><a href="https://github.com/igrigorik/em-websocket/commits/master" highlight="repo_commits">Commits</a></li>
    <li><a href="/igrigorik/em-websocket/network" highlight="repo_network">Network</a></li>
    <li><a href="/igrigorik/em-websocket/pulls" highlight="repo_pulls">Pull Requests (1)</a></li>

    

    
      
      <li><a href="/igrigorik/em-websocket/issues" highlight="issues">Issues (7)</a></li>
    

                <li><a href="/igrigorik/em-websocket/wiki" highlight="repo_wiki">Wiki (1)</a></li>
        
    <li><a href="/igrigorik/em-websocket/graphs" highlight="repo_graphs">Graphs</a></li>

    <li class="contextswitch nochoices">
      <span class="toggle leftwards" >
        <em>Branch:</em>
        <code>master</code>
      </span>
    </li>
  </ul>

  <div style="display:none" id="pl-description"><p><em class="placeholder">click here to add a description</em></p></div>
  <div style="display:none" id="pl-homepage"><p><em class="placeholder">click here to add a homepage</em></p></div>

  <div class="subnav-bar">
  
  <ul>
    <li>
      <a href="#" class="dropdown">Switch Branches (4)</a>
      <ul>
        
          
          
            <li><a href="/igrigorik/em-websocket/blob/draft03/examples/js/swfobject.js" action="show">draft03</a></li>
          
        
          
            <li><strong>master &#x2713;</strong></li>
            
          
          
            <li><a href="/igrigorik/em-websocket/blob/onerror/examples/js/swfobject.js" action="show">onerror</a></li>
          
        
          
          
            <li><a href="/igrigorik/em-websocket/blob/ruby19fixes/examples/js/swfobject.js" action="show">ruby19fixes</a></li>
          
        
      </ul>
    </li>
    <li>
      <a href="#" class="dropdown ">Switch Tags (2)</a>
              <ul>
                      
              <li><a href="/igrigorik/em-websocket/blob/v0.2.0/examples/js/swfobject.js">v0.2.0</a></li>
            
                      
              <li><a href="/igrigorik/em-websocket/blob/v0.1.4/examples/js/swfobject.js">v0.1.4</a></li>
            
                  </ul>
      
    </li>
    <li>
    
    <a href="/igrigorik/em-websocket/branches" class="manage">Branch List</a>
    
    </li>
  </ul>
</div>

  
  
  
  
  
  



        
    <div class="frame frame-center tree-finder" style="display: none">
      <div class="breadcrumb">
        <b><a href="/igrigorik/em-websocket">em-websocket</a></b> /
        <input class="tree-finder-input" type="text" name="query" autocomplete="off" spellcheck="false">
      </div>

      
        <div class="octotip">
          <p>
            <a href="/igrigorik/em-websocket/dismiss-tree-finder-help" class="dismiss js-dismiss-tree-list-help" title="Hide this notice forever">Dismiss</a>
            <strong>Octotip:</strong> You've activated the <em>file finder</em> by pressing <span class="kbd">t</span>
            Start typing to filter the file list. Use <span class="kbd badmono">↑</span> and <span class="kbd badmono">↓</span> to navigate,
            <span class="kbd">enter</span> to view files.
          </p>
        </div>
      

      <table class="tree-browser" cellpadding="0" cellspacing="0">
        <tr class="js-header"><th>&nbsp;</th><th>name</th></tr>
        <tr class="js-no-results no-results" style="display: none">
          <th colspan="2">No matching files</th>
        </tr>
        <tbody class="js-results-list">
        </tbody>
      </table>
    </div>

    <div id="repo_details" class="metabox clearfix">
      <div id="repo_details_loader" class="metabox-loader" style="display:none">Sending Request&hellip;</div>

        <a href="/igrigorik/em-websocket/downloads" class="download-source" id="download_button" title="Download source, tagged packages and binaries."><span class="icon"></span>Downloads</a>

      <div id="repository_desc_wrapper">
      <div id="repository_description" rel="repository_description_edit">
        
          <p>EventMachine based WebSocket server
            <span id="read_more" style="display:none">&mdash; <a href="#readme">Read more</a></span>
          </p>
        
      </div>

      <div id="repository_description_edit" style="display:none;" class="inline-edit">
        <form action="/igrigorik/em-websocket/admin/update" method="post"><div style="margin:0;padding:0"><input name="authenticity_token" type="hidden" value="ba41504442878ffdb5ad00e716b7d565fbb4dca8" /></div>
          <input type="hidden" name="field" value="repository_description">
          <input type="text" class="textfield" name="value" value="EventMachine based WebSocket server">
          <div class="form-actions">
            <button class="minibutton"><span>Save</span></button> &nbsp; <a href="#" class="cancel">Cancel</a>
          </div>
        </form>
      </div>

      
      <div class="repository-homepage" id="repository_homepage" rel="repository_homepage_edit">
        <p><a href="http://www.igvita.com/2009/12/22/ruby-websockets-tcp-for-the-browser/" rel="nofollow">http://www.igvita.com/2009/12/22/ruby-websockets-tcp-for-the-browser/</a></p>
      </div>

      <div id="repository_homepage_edit" style="display:none;" class="inline-edit">
        <form action="/igrigorik/em-websocket/admin/update" method="post"><div style="margin:0;padding:0"><input name="authenticity_token" type="hidden" value="ba41504442878ffdb5ad00e716b7d565fbb4dca8" /></div>
          <input type="hidden" name="field" value="repository_homepage">
          <input type="text" class="textfield" name="value" value="http://www.igvita.com/2009/12/22/ruby-websockets-tcp-for-the-browser/">
          <div class="form-actions">
            <button class="minibutton"><span>Save</span></button> &nbsp; <a href="#" class="cancel">Cancel</a>
          </div>
        </form>
      </div>
      </div>
      <div class="rule "></div>
            <div id="url_box" class="url-box">
        <ul class="clone-urls">
          
            
            <li id="http_clone_url"><a href="https://github.com/igrigorik/em-websocket.git" data-permissions="Read-Only">HTTP</a></li>
            <li id="public_clone_url"><a href="git://github.com/igrigorik/em-websocket.git" data-permissions="Read-Only">Git Read-Only</a></li>
          
          
        </ul>
        <input type="text" spellcheck="false" id="url_field" class="url-field" />
              <span style="display:none" id="url_box_clippy"></span>
      <span id="clippy_tooltip_url_box_clippy" class="clippy-tooltip tooltipped" title="copy to clipboard">
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
              width="14"
              height="14"
              class="clippy"
              id="clippy" >
      <param name="movie" value="https://assets3.github.com/flash/clippy.swf?v5"/>
      <param name="allowScriptAccess" value="always" />
      <param name="quality" value="high" />
      <param name="scale" value="noscale" />
      <param NAME="FlashVars" value="id=url_box_clippy&amp;copied=&amp;copyto=">
      <param name="bgcolor" value="#FFFFFF">
      <param name="wmode" value="opaque">
      <embed src="https://assets3.github.com/flash/clippy.swf?v5"
             width="14"
             height="14"
             name="clippy"
             quality="high"
             allowScriptAccess="always"
             type="application/x-shockwave-flash"
             pluginspage="http://www.macromedia.com/go/getflashplayer"
             FlashVars="id=url_box_clippy&amp;copied=&amp;copyto="
             bgcolor="#FFFFFF"
             wmode="opaque"
      />
      </object>
      </span>

        <p id="url_description">This URL has <strong>Read+Write</strong> access</p>
      </div>
    </div>


        

      </div><!-- /.pagehead -->

      





<script type="text/javascript">
  GitHub.downloadRepo = '/igrigorik/em-websocket/archives/master'
  GitHub.revType = "master"

  GitHub.controllerName = "blob"
  GitHub.actionName     = "show"
  GitHub.currentAction  = "blob#show"

  

  
</script>






<div class="flash-messages"></div>


  <div id="commit">
    <div class="group">
        
  <div class="envelope commit">
    <div class="human">
      
        <div class="message"><pre><a href="/igrigorik/em-websocket/commit/cdedd7bd5c43e25fd0b30236889bc131b5cbe495">Added Gemfile.lock to gitignore</a> </pre></div>
      

      <div class="actor">
        <div class="gravatar">
          
          <img src="https://secure.gravatar.com/avatar/b96c2426a6ef84c069876e80e49a600b?s=140&d=https://github.com%2Fimages%2Fgravatars%2Fgravatar-140.png" alt="" width="30" height="30"  />
        </div>
        <div class="name"><a href="/mloughran">mloughran</a> <span>(author)</span></div>
        <div class="date">
          <abbr class="relatize" title="2011-02-07 04:29:18">Mon Feb 07 04:29:18 -0800 2011</abbr>
        </div>
      </div>

      

    </div>
    <div class="machine">
      <span>c</span>ommit&nbsp;&nbsp;<a href="/igrigorik/em-websocket/commit/cdedd7bd5c43e25fd0b30236889bc131b5cbe495" hotkey="c">cdedd7bd5c43e25fd0b3</a><br />
      <span>t</span>ree&nbsp;&nbsp;&nbsp;&nbsp;<a href="/igrigorik/em-websocket/tree/cdedd7bd5c43e25fd0b30236889bc131b5cbe495" hotkey="t">087af53398020bbc09b5</a><br />
      
        <span>p</span>arent&nbsp;
        
        <a href="/igrigorik/em-websocket/tree/97c850128ccd49063d12dde2512cbdd1d3c128a2" hotkey="p">97c850128ccd49063d12</a>
      

    </div>
  </div>

    </div>
  </div>



  <div id="slider">

  

    <div class="breadcrumb" data-path="examples/js/swfobject.js/">
      <b><a href="/igrigorik/em-websocket/tree/cdedd7bd5c43e25fd0b30236889bc131b5cbe495">em-websocket</a></b> / <a href="/igrigorik/em-websocket/tree/cdedd7bd5c43e25fd0b30236889bc131b5cbe495/examples">examples</a> / <a href="/igrigorik/em-websocket/tree/cdedd7bd5c43e25fd0b30236889bc131b5cbe495/examples/js">js</a> / swfobject.js       <span style="display:none" id="clippy_2481">examples/js/swfobject.js</span>
      
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
              width="110"
              height="14"
              class="clippy"
              id="clippy" >
      <param name="movie" value="https://assets3.github.com/flash/clippy.swf?v5"/>
      <param name="allowScriptAccess" value="always" />
      <param name="quality" value="high" />
      <param name="scale" value="noscale" />
      <param NAME="FlashVars" value="id=clippy_2481&amp;copied=copied!&amp;copyto=copy to clipboard">
      <param name="bgcolor" value="#FFFFFF">
      <param name="wmode" value="opaque">
      <embed src="https://assets3.github.com/flash/clippy.swf?v5"
             width="110"
             height="14"
             name="clippy"
             quality="high"
             allowScriptAccess="always"
             type="application/x-shockwave-flash"
             pluginspage="http://www.macromedia.com/go/getflashplayer"
             FlashVars="id=clippy_2481&amp;copied=copied!&amp;copyto=copy to clipboard"
             bgcolor="#FFFFFF"
             wmode="opaque"
      />
      </object>
      

    </div>

    <div class="frames">
      <div class="frame frame-center" data-path="examples/js/swfobject.js/">
        
          <ul class="big-actions">
            
            <li><a class="file-edit-link minibutton" href="/igrigorik/em-websocket/file-edit/__current_ref__/examples/js/swfobject.js"><span>Edit this file</span></a></li>
          </ul>
        

        <div id="files">
          <div class="file">
            <div class="meta">
              <div class="info">
                <span class="icon"><img alt="Txt" height="16" src="https://assets0.github.com/images/icons/txt.png?d3c378b28a5d133a320457e8392e64e1e65ef658" width="16" /></span>
                <span class="mode" title="File Mode">100644</span>
                
                  <span>4 lines (4 sloc)</span>
                
                <span>10.22 kb</span>
              </div>
              <ul class="actions">
                <li><a href="/igrigorik/em-websocket/raw/master/examples/js/swfobject.js" id="raw-url">raw</a></li>
                
                  <li><a href="/igrigorik/em-websocket/blame/master/examples/js/swfobject.js">blame</a></li>
                
                <li><a href="/igrigorik/em-websocket/commits/master/examples/js/swfobject.js">history</a></li>
              </ul>
            </div>
            
  <div class="data type-javascript">
    
      <table cellpadding="0" cellspacing="0">
        <tr>
          <td>
            <pre class="line_numbers"><span id="L1" rel="#L1">1</span>
<span id="L2" rel="#L2">2</span>
<span id="L3" rel="#L3">3</span>
<span id="L4" rel="#L4">4</span>
</pre>
          </td>
          <td width="100%">
            
              
                <div class="highlight"><pre><div class='line' id='LC1'><span class="cm">/*	SWFObject v2.2 &lt;http://code.google.com/p/swfobject/&gt; </span></div><div class='line' id='LC2'><span class="cm">	is released under the MIT License &lt;http://www.opensource.org/licenses/mit-license.php&gt; </span></div><div class='line' id='LC3'><span class="cm">*/</span></div><div class='line' id='LC4'><span class="kd">var</span> <span class="nx">swfobject</span><span class="o">=</span><span class="kd">function</span><span class="p">(){</span><span class="kd">var</span> <span class="nx">D</span><span class="o">=</span><span class="s2">&quot;undefined&quot;</span><span class="p">,</span><span class="nx">r</span><span class="o">=</span><span class="s2">&quot;object&quot;</span><span class="p">,</span><span class="nx">S</span><span class="o">=</span><span class="s2">&quot;Shockwave Flash&quot;</span><span class="p">,</span><span class="nx">W</span><span class="o">=</span><span class="s2">&quot;ShockwaveFlash.ShockwaveFlash&quot;</span><span class="p">,</span><span class="nx">q</span><span class="o">=</span><span class="s2">&quot;application/x-shockwave-flash&quot;</span><span class="p">,</span><span class="nx">R</span><span class="o">=</span><span class="s2">&quot;SWFObjectExprInst&quot;</span><span class="p">,</span><span class="nx">x</span><span class="o">=</span><span class="s2">&quot;onreadystatechange&quot;</span><span class="p">,</span><span class="nx">O</span><span class="o">=</span><span class="nb">window</span><span class="p">,</span><span class="nx">j</span><span class="o">=</span><span class="nb">document</span><span class="p">,</span><span class="nx">t</span><span class="o">=</span><span class="nx">navigator</span><span class="p">,</span><span class="nx">T</span><span class="o">=</span><span class="kc">false</span><span class="p">,</span><span class="nx">U</span><span class="o">=</span><span class="p">[</span><span class="nx">h</span><span class="p">],</span><span class="nx">o</span><span class="o">=</span><span class="p">[],</span><span class="nx">N</span><span class="o">=</span><span class="p">[],</span><span class="nx">I</span><span class="o">=</span><span class="p">[],</span><span class="nx">l</span><span class="p">,</span><span class="nx">Q</span><span class="p">,</span><span class="nx">E</span><span class="p">,</span><span class="nx">B</span><span class="p">,</span><span class="nx">J</span><span class="o">=</span><span class="kc">false</span><span class="p">,</span><span class="nx">a</span><span class="o">=</span><span class="kc">false</span><span class="p">,</span><span class="nx">n</span><span class="p">,</span><span class="nx">G</span><span class="p">,</span><span class="nx">m</span><span class="o">=</span><span class="kc">true</span><span class="p">,</span><span class="nx">M</span><span class="o">=</span><span class="kd">function</span><span class="p">(){</span><span class="kd">var</span> <span class="nx">aa</span><span class="o">=</span><span class="k">typeof</span> <span class="nx">j</span><span class="p">.</span><span class="nx">getElementById</span><span class="o">!=</span><span class="nx">D</span><span class="o">&amp;&amp;</span><span class="k">typeof</span> <span class="nx">j</span><span class="p">.</span><span class="nx">getElementsByTagName</span><span class="o">!=</span><span class="nx">D</span><span class="o">&amp;&amp;</span><span class="k">typeof</span> <span class="nx">j</span><span class="p">.</span><span class="nx">createElement</span><span class="o">!=</span><span class="nx">D</span><span class="p">,</span><span class="nx">ah</span><span class="o">=</span><span class="nx">t</span><span class="p">.</span><span class="nx">userAgent</span><span class="p">.</span><span class="nx">toLowerCase</span><span class="p">(),</span><span class="nx">Y</span><span class="o">=</span><span class="nx">t</span><span class="p">.</span><span class="nx">platform</span><span class="p">.</span><span class="nx">toLowerCase</span><span class="p">(),</span><span class="nx">ae</span><span class="o">=</span><span class="nx">Y</span><span class="o">?</span><span class="sr">/win/</span><span class="p">.</span><span class="nx">test</span><span class="p">(</span><span class="nx">Y</span><span class="p">)</span><span class="o">:</span><span class="sr">/win/</span><span class="p">.</span><span class="nx">test</span><span class="p">(</span><span class="nx">ah</span><span class="p">),</span><span class="nx">ac</span><span class="o">=</span><span class="nx">Y</span><span class="o">?</span><span class="sr">/mac/</span><span class="p">.</span><span class="nx">test</span><span class="p">(</span><span class="nx">Y</span><span class="p">)</span><span class="o">:</span><span class="sr">/mac/</span><span class="p">.</span><span class="nx">test</span><span class="p">(</span><span class="nx">ah</span><span class="p">),</span><span class="nx">af</span><span class="o">=</span><span class="sr">/webkit/</span><span class="p">.</span><span class="nx">test</span><span class="p">(</span><span class="nx">ah</span><span class="p">)</span><span class="o">?</span><span class="nb">parseFloat</span><span class="p">(</span><span class="nx">ah</span><span class="p">.</span><span class="nx">replace</span><span class="p">(</span><span class="sr">/^.*webkit\/(\d+(\.\d+)?).*$/</span><span class="p">,</span><span class="s2">&quot;$1&quot;</span><span class="p">))</span><span class="o">:</span><span class="kc">false</span><span class="p">,</span><span class="nx">X</span><span class="o">=!+</span><span class="s2">&quot;\v1&quot;</span><span class="p">,</span><span class="nx">ag</span><span class="o">=</span><span class="p">[</span><span class="mi">0</span><span class="p">,</span><span class="mi">0</span><span class="p">,</span><span class="mi">0</span><span class="p">],</span><span class="nx">ab</span><span class="o">=</span><span class="kc">null</span><span class="p">;</span><span class="k">if</span><span class="p">(</span><span class="k">typeof</span> <span class="nx">t</span><span class="p">.</span><span class="nx">plugins</span><span class="o">!=</span><span class="nx">D</span><span class="o">&amp;&amp;</span><span class="k">typeof</span> <span class="nx">t</span><span class="p">.</span><span class="nx">plugins</span><span class="p">[</span><span class="nx">S</span><span class="p">]</span><span class="o">==</span><span class="nx">r</span><span class="p">){</span><span class="nx">ab</span><span class="o">=</span><span class="nx">t</span><span class="p">.</span><span class="nx">plugins</span><span class="p">[</span><span class="nx">S</span><span class="p">].</span><span class="nx">description</span><span class="p">;</span><span class="k">if</span><span class="p">(</span><span class="nx">ab</span><span class="o">&amp;&amp;!</span><span class="p">(</span><span class="k">typeof</span> <span class="nx">t</span><span class="p">.</span><span class="nx">mimeTypes</span><span class="o">!=</span><span class="nx">D</span><span class="o">&amp;&amp;</span><span class="nx">t</span><span class="p">.</span><span class="nx">mimeTypes</span><span class="p">[</span><span class="nx">q</span><span class="p">]</span><span class="o">&amp;&amp;!</span><span class="nx">t</span><span class="p">.</span><span class="nx">mimeTypes</span><span class="p">[</span><span class="nx">q</span><span class="p">].</span><span class="nx">enabledPlugin</span><span class="p">)){</span><span class="nx">T</span><span class="o">=</span><span class="kc">true</span><span class="p">;</span><span class="nx">X</span><span class="o">=</span><span class="kc">false</span><span class="p">;</span><span class="nx">ab</span><span class="o">=</span><span class="nx">ab</span><span class="p">.</span><span class="nx">replace</span><span class="p">(</span><span class="sr">/^.*\s+(\S+\s+\S+$)/</span><span class="p">,</span><span class="s2">&quot;$1&quot;</span><span class="p">);</span><span class="nx">ag</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span><span class="o">=</span><span class="nb">parseInt</span><span class="p">(</span><span class="nx">ab</span><span class="p">.</span><span class="nx">replace</span><span class="p">(</span><span class="sr">/^(.*)\..*$/</span><span class="p">,</span><span class="s2">&quot;$1&quot;</span><span class="p">),</span><span class="mi">10</span><span class="p">);</span><span class="nx">ag</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span><span class="o">=</span><span class="nb">parseInt</span><span class="p">(</span><span class="nx">ab</span><span class="p">.</span><span class="nx">replace</span><span class="p">(</span><span class="sr">/^.*\.(.*)\s.*$/</span><span class="p">,</span><span class="s2">&quot;$1&quot;</span><span class="p">),</span><span class="mi">10</span><span class="p">);</span><span class="nx">ag</span><span class="p">[</span><span class="mi">2</span><span class="p">]</span><span class="o">=</span><span class="sr">/[a-zA-Z]/</span><span class="p">.</span><span class="nx">test</span><span class="p">(</span><span class="nx">ab</span><span class="p">)</span><span class="o">?</span><span class="nb">parseInt</span><span class="p">(</span><span class="nx">ab</span><span class="p">.</span><span class="nx">replace</span><span class="p">(</span><span class="sr">/^.*[a-zA-Z]+(.*)$/</span><span class="p">,</span><span class="s2">&quot;$1&quot;</span><span class="p">),</span><span class="mi">10</span><span class="p">)</span><span class="o">:</span><span class="mi">0</span><span class="p">}}</span><span class="k">else</span><span class="p">{</span><span class="k">if</span><span class="p">(</span><span class="k">typeof</span> <span class="nx">O</span><span class="p">.</span><span class="nx">ActiveXObject</span><span class="o">!=</span><span class="nx">D</span><span class="p">){</span><span class="k">try</span><span class="p">{</span><span class="kd">var</span> <span class="nx">ad</span><span class="o">=</span><span class="k">new</span> <span class="nx">ActiveXObject</span><span class="p">(</span><span class="nx">W</span><span class="p">);</span><span class="k">if</span><span class="p">(</span><span class="nx">ad</span><span class="p">){</span><span class="nx">ab</span><span class="o">=</span><span class="nx">ad</span><span class="p">.</span><span class="nx">GetVariable</span><span class="p">(</span><span class="s2">&quot;$version&quot;</span><span class="p">);</span><span class="k">if</span><span class="p">(</span><span class="nx">ab</span><span class="p">){</span><span class="nx">X</span><span class="o">=</span><span class="kc">true</span><span class="p">;</span><span class="nx">ab</span><span class="o">=</span><span class="nx">ab</span><span class="p">.</span><span class="nx">split</span><span class="p">(</span><span class="s2">&quot; &quot;</span><span class="p">)[</span><span class="mi">1</span><span class="p">].</span><span class="nx">split</span><span class="p">(</span><span class="s2">&quot;,&quot;</span><span class="p">);</span><span class="nx">ag</span><span class="o">=</span><span class="p">[</span><span class="nb">parseInt</span><span class="p">(</span><span class="nx">ab</span><span class="p">[</span><span class="mi">0</span><span class="p">],</span><span class="mi">10</span><span class="p">),</span><span class="nb">parseInt</span><span class="p">(</span><span class="nx">ab</span><span class="p">[</span><span class="mi">1</span><span class="p">],</span><span class="mi">10</span><span class="p">),</span><span class="nb">parseInt</span><span class="p">(</span><span class="nx">ab</span><span class="p">[</span><span class="mi">2</span><span class="p">],</span><span class="mi">10</span><span class="p">)]}}}</span><span class="k">catch</span><span class="p">(</span><span class="nx">Z</span><span class="p">){}}}</span><span class="k">return</span><span class="p">{</span><span class="nx">w3</span><span class="o">:</span><span class="nx">aa</span><span class="p">,</span><span class="nx">pv</span><span class="o">:</span><span class="nx">ag</span><span class="p">,</span><span class="nx">wk</span><span class="o">:</span><span class="nx">af</span><span class="p">,</span><span class="nx">ie</span><span class="o">:</span><span class="nx">X</span><span class="p">,</span><span class="nx">win</span><span class="o">:</span><span class="nx">ae</span><span class="p">,</span><span class="nx">mac</span><span class="o">:</span><span class="nx">ac</span><span class="p">}}(),</span><span class="nx">k</span><span class="o">=</span><span class="kd">function</span><span class="p">(){</span><span class="k">if</span><span class="p">(</span><span class="o">!</span><span class="nx">M</span><span class="p">.</span><span class="nx">w3</span><span class="p">){</span><span class="k">return</span><span class="p">}</span><span class="k">if</span><span class="p">((</span><span class="k">typeof</span> <span class="nx">j</span><span class="p">.</span><span class="nx">readyState</span><span class="o">!=</span><span class="nx">D</span><span class="o">&amp;&amp;</span><span class="nx">j</span><span class="p">.</span><span class="nx">readyState</span><span class="o">==</span><span class="s2">&quot;complete&quot;</span><span class="p">)</span><span class="o">||</span><span class="p">(</span><span class="k">typeof</span> <span class="nx">j</span><span class="p">.</span><span class="nx">readyState</span><span class="o">==</span><span class="nx">D</span><span class="o">&amp;&amp;</span><span class="p">(</span><span class="nx">j</span><span class="p">.</span><span class="nx">getElementsByTagName</span><span class="p">(</span><span class="s2">&quot;body&quot;</span><span class="p">)[</span><span class="mi">0</span><span class="p">]</span><span class="o">||</span><span class="nx">j</span><span class="p">.</span><span class="nx">body</span><span class="p">))){</span><span class="nx">f</span><span class="p">()}</span><span class="k">if</span><span class="p">(</span><span class="o">!</span><span class="nx">J</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="k">typeof</span> <span class="nx">j</span><span class="p">.</span><span class="nx">addEventListener</span><span class="o">!=</span><span class="nx">D</span><span class="p">){</span><span class="nx">j</span><span class="p">.</span><span class="nx">addEventListener</span><span class="p">(</span><span class="s2">&quot;DOMContentLoaded&quot;</span><span class="p">,</span><span class="nx">f</span><span class="p">,</span><span class="kc">false</span><span class="p">)}</span><span class="k">if</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">ie</span><span class="o">&amp;&amp;</span><span class="nx">M</span><span class="p">.</span><span class="nx">win</span><span class="p">){</span><span class="nx">j</span><span class="p">.</span><span class="nx">attachEvent</span><span class="p">(</span><span class="nx">x</span><span class="p">,</span><span class="kd">function</span><span class="p">(){</span><span class="k">if</span><span class="p">(</span><span class="nx">j</span><span class="p">.</span><span class="nx">readyState</span><span class="o">==</span><span class="s2">&quot;complete&quot;</span><span class="p">){</span><span class="nx">j</span><span class="p">.</span><span class="nx">detachEvent</span><span class="p">(</span><span class="nx">x</span><span class="p">,</span><span class="nx">arguments</span><span class="p">.</span><span class="nx">callee</span><span class="p">);</span><span class="nx">f</span><span class="p">()}});</span><span class="k">if</span><span class="p">(</span><span class="nx">O</span><span class="o">==</span><span class="nx">top</span><span class="p">){(</span><span class="kd">function</span><span class="p">(){</span><span class="k">if</span><span class="p">(</span><span class="nx">J</span><span class="p">){</span><span class="k">return</span><span class="p">}</span><span class="k">try</span><span class="p">{</span><span class="nx">j</span><span class="p">.</span><span class="nx">documentElement</span><span class="p">.</span><span class="nx">doScroll</span><span class="p">(</span><span class="s2">&quot;left&quot;</span><span class="p">)}</span><span class="k">catch</span><span class="p">(</span><span class="nx">X</span><span class="p">){</span><span class="nx">setTimeout</span><span class="p">(</span><span class="nx">arguments</span><span class="p">.</span><span class="nx">callee</span><span class="p">,</span><span class="mi">0</span><span class="p">);</span><span class="k">return</span><span class="p">}</span><span class="nx">f</span><span class="p">()})()}}</span><span class="k">if</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">wk</span><span class="p">){(</span><span class="kd">function</span><span class="p">(){</span><span class="k">if</span><span class="p">(</span><span class="nx">J</span><span class="p">){</span><span class="k">return</span><span class="p">}</span><span class="k">if</span><span class="p">(</span><span class="o">!</span><span class="sr">/loaded|complete/</span><span class="p">.</span><span class="nx">test</span><span class="p">(</span><span class="nx">j</span><span class="p">.</span><span class="nx">readyState</span><span class="p">)){</span><span class="nx">setTimeout</span><span class="p">(</span><span class="nx">arguments</span><span class="p">.</span><span class="nx">callee</span><span class="p">,</span><span class="mi">0</span><span class="p">);</span><span class="k">return</span><span class="p">}</span><span class="nx">f</span><span class="p">()})()}</span><span class="nx">s</span><span class="p">(</span><span class="nx">f</span><span class="p">)}}();</span><span class="kd">function</span> <span class="nx">f</span><span class="p">(){</span><span class="k">if</span><span class="p">(</span><span class="nx">J</span><span class="p">){</span><span class="k">return</span><span class="p">}</span><span class="k">try</span><span class="p">{</span><span class="kd">var</span> <span class="nx">Z</span><span class="o">=</span><span class="nx">j</span><span class="p">.</span><span class="nx">getElementsByTagName</span><span class="p">(</span><span class="s2">&quot;body&quot;</span><span class="p">)[</span><span class="mi">0</span><span class="p">].</span><span class="nx">appendChild</span><span class="p">(</span><span class="nx">C</span><span class="p">(</span><span class="s2">&quot;span&quot;</span><span class="p">));</span><span class="nx">Z</span><span class="p">.</span><span class="nx">parentNode</span><span class="p">.</span><span class="nx">removeChild</span><span class="p">(</span><span class="nx">Z</span><span class="p">)}</span><span class="k">catch</span><span class="p">(</span><span class="nx">aa</span><span class="p">){</span><span class="k">return</span><span class="p">}</span><span class="nx">J</span><span class="o">=</span><span class="kc">true</span><span class="p">;</span><span class="kd">var</span> <span class="nx">X</span><span class="o">=</span><span class="nx">U</span><span class="p">.</span><span class="nx">length</span><span class="p">;</span><span class="k">for</span><span class="p">(</span><span class="kd">var</span> <span class="nx">Y</span><span class="o">=</span><span class="mi">0</span><span class="p">;</span><span class="nx">Y</span><span class="o">&lt;</span><span class="nx">X</span><span class="p">;</span><span class="nx">Y</span><span class="o">++</span><span class="p">){</span><span class="nx">U</span><span class="p">[</span><span class="nx">Y</span><span class="p">]()}}</span><span class="kd">function</span> <span class="nx">K</span><span class="p">(</span><span class="nx">X</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="nx">J</span><span class="p">){</span><span class="nx">X</span><span class="p">()}</span><span class="k">else</span><span class="p">{</span><span class="nx">U</span><span class="p">[</span><span class="nx">U</span><span class="p">.</span><span class="nx">length</span><span class="p">]</span><span class="o">=</span><span class="nx">X</span><span class="p">}}</span><span class="kd">function</span> <span class="nx">s</span><span class="p">(</span><span class="nx">Y</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="k">typeof</span> <span class="nx">O</span><span class="p">.</span><span class="nx">addEventListener</span><span class="o">!=</span><span class="nx">D</span><span class="p">){</span><span class="nx">O</span><span class="p">.</span><span class="nx">addEventListener</span><span class="p">(</span><span class="s2">&quot;load&quot;</span><span class="p">,</span><span class="nx">Y</span><span class="p">,</span><span class="kc">false</span><span class="p">)}</span><span class="k">else</span><span class="p">{</span><span class="k">if</span><span class="p">(</span><span class="k">typeof</span> <span class="nx">j</span><span class="p">.</span><span class="nx">addEventListener</span><span class="o">!=</span><span class="nx">D</span><span class="p">){</span><span class="nx">j</span><span class="p">.</span><span class="nx">addEventListener</span><span class="p">(</span><span class="s2">&quot;load&quot;</span><span class="p">,</span><span class="nx">Y</span><span class="p">,</span><span class="kc">false</span><span class="p">)}</span><span class="k">else</span><span class="p">{</span><span class="k">if</span><span class="p">(</span><span class="k">typeof</span> <span class="nx">O</span><span class="p">.</span><span class="nx">attachEvent</span><span class="o">!=</span><span class="nx">D</span><span class="p">){</span><span class="nx">i</span><span class="p">(</span><span class="nx">O</span><span class="p">,</span><span class="s2">&quot;onload&quot;</span><span class="p">,</span><span class="nx">Y</span><span class="p">)}</span><span class="k">else</span><span class="p">{</span><span class="k">if</span><span class="p">(</span><span class="k">typeof</span> <span class="nx">O</span><span class="p">.</span><span class="nx">onload</span><span class="o">==</span><span class="s2">&quot;function&quot;</span><span class="p">){</span><span class="kd">var</span> <span class="nx">X</span><span class="o">=</span><span class="nx">O</span><span class="p">.</span><span class="nx">onload</span><span class="p">;</span><span class="nx">O</span><span class="p">.</span><span class="nx">onload</span><span class="o">=</span><span class="kd">function</span><span class="p">(){</span><span class="nx">X</span><span class="p">();</span><span class="nx">Y</span><span class="p">()}}</span><span class="k">else</span><span class="p">{</span><span class="nx">O</span><span class="p">.</span><span class="nx">onload</span><span class="o">=</span><span class="nx">Y</span><span class="p">}}}}}</span><span class="kd">function</span> <span class="nx">h</span><span class="p">(){</span><span class="k">if</span><span class="p">(</span><span class="nx">T</span><span class="p">){</span><span class="nx">V</span><span class="p">()}</span><span class="k">else</span><span class="p">{</span><span class="nx">H</span><span class="p">()}}</span><span class="kd">function</span> <span class="nx">V</span><span class="p">(){</span><span class="kd">var</span> <span class="nx">X</span><span class="o">=</span><span class="nx">j</span><span class="p">.</span><span class="nx">getElementsByTagName</span><span class="p">(</span><span class="s2">&quot;body&quot;</span><span class="p">)[</span><span class="mi">0</span><span class="p">];</span><span class="kd">var</span> <span class="nx">aa</span><span class="o">=</span><span class="nx">C</span><span class="p">(</span><span class="nx">r</span><span class="p">);</span><span class="nx">aa</span><span class="p">.</span><span class="nx">setAttribute</span><span class="p">(</span><span class="s2">&quot;type&quot;</span><span class="p">,</span><span class="nx">q</span><span class="p">);</span><span class="kd">var</span> <span class="nx">Z</span><span class="o">=</span><span class="nx">X</span><span class="p">.</span><span class="nx">appendChild</span><span class="p">(</span><span class="nx">aa</span><span class="p">);</span><span class="k">if</span><span class="p">(</span><span class="nx">Z</span><span class="p">){</span><span class="kd">var</span> <span class="nx">Y</span><span class="o">=</span><span class="mi">0</span><span class="p">;(</span><span class="kd">function</span><span class="p">(){</span><span class="k">if</span><span class="p">(</span><span class="k">typeof</span> <span class="nx">Z</span><span class="p">.</span><span class="nx">GetVariable</span><span class="o">!=</span><span class="nx">D</span><span class="p">){</span><span class="kd">var</span> <span class="nx">ab</span><span class="o">=</span><span class="nx">Z</span><span class="p">.</span><span class="nx">GetVariable</span><span class="p">(</span><span class="s2">&quot;$version&quot;</span><span class="p">);</span><span class="k">if</span><span class="p">(</span><span class="nx">ab</span><span class="p">){</span><span class="nx">ab</span><span class="o">=</span><span class="nx">ab</span><span class="p">.</span><span class="nx">split</span><span class="p">(</span><span class="s2">&quot; &quot;</span><span class="p">)[</span><span class="mi">1</span><span class="p">].</span><span class="nx">split</span><span class="p">(</span><span class="s2">&quot;,&quot;</span><span class="p">);</span><span class="nx">M</span><span class="p">.</span><span class="nx">pv</span><span class="o">=</span><span class="p">[</span><span class="nb">parseInt</span><span class="p">(</span><span class="nx">ab</span><span class="p">[</span><span class="mi">0</span><span class="p">],</span><span class="mi">10</span><span class="p">),</span><span class="nb">parseInt</span><span class="p">(</span><span class="nx">ab</span><span class="p">[</span><span class="mi">1</span><span class="p">],</span><span class="mi">10</span><span class="p">),</span><span class="nb">parseInt</span><span class="p">(</span><span class="nx">ab</span><span class="p">[</span><span class="mi">2</span><span class="p">],</span><span class="mi">10</span><span class="p">)]}}</span><span class="k">else</span><span class="p">{</span><span class="k">if</span><span class="p">(</span><span class="nx">Y</span><span class="o">&lt;</span><span class="mi">10</span><span class="p">){</span><span class="nx">Y</span><span class="o">++</span><span class="p">;</span><span class="nx">setTimeout</span><span class="p">(</span><span class="nx">arguments</span><span class="p">.</span><span class="nx">callee</span><span class="p">,</span><span class="mi">10</span><span class="p">);</span><span class="k">return</span><span class="p">}}</span><span class="nx">X</span><span class="p">.</span><span class="nx">removeChild</span><span class="p">(</span><span class="nx">aa</span><span class="p">);</span><span class="nx">Z</span><span class="o">=</span><span class="kc">null</span><span class="p">;</span><span class="nx">H</span><span class="p">()})()}</span><span class="k">else</span><span class="p">{</span><span class="nx">H</span><span class="p">()}}</span><span class="kd">function</span> <span class="nx">H</span><span class="p">(){</span><span class="kd">var</span> <span class="nx">ag</span><span class="o">=</span><span class="nx">o</span><span class="p">.</span><span class="nx">length</span><span class="p">;</span><span class="k">if</span><span class="p">(</span><span class="nx">ag</span><span class="o">&gt;</span><span class="mi">0</span><span class="p">){</span><span class="k">for</span><span class="p">(</span><span class="kd">var</span> <span class="nx">af</span><span class="o">=</span><span class="mi">0</span><span class="p">;</span><span class="nx">af</span><span class="o">&lt;</span><span class="nx">ag</span><span class="p">;</span><span class="nx">af</span><span class="o">++</span><span class="p">){</span><span class="kd">var</span> <span class="nx">Y</span><span class="o">=</span><span class="nx">o</span><span class="p">[</span><span class="nx">af</span><span class="p">].</span><span class="nx">id</span><span class="p">;</span><span class="kd">var</span> <span class="nx">ab</span><span class="o">=</span><span class="nx">o</span><span class="p">[</span><span class="nx">af</span><span class="p">].</span><span class="nx">callbackFn</span><span class="p">;</span><span class="kd">var</span> <span class="nx">aa</span><span class="o">=</span><span class="p">{</span><span class="nx">success</span><span class="o">:</span><span class="kc">false</span><span class="p">,</span><span class="nx">id</span><span class="o">:</span><span class="nx">Y</span><span class="p">};</span><span class="k">if</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">pv</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span><span class="o">&gt;</span><span class="mi">0</span><span class="p">){</span><span class="kd">var</span> <span class="nx">ae</span><span class="o">=</span><span class="nx">c</span><span class="p">(</span><span class="nx">Y</span><span class="p">);</span><span class="k">if</span><span class="p">(</span><span class="nx">ae</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="nx">F</span><span class="p">(</span><span class="nx">o</span><span class="p">[</span><span class="nx">af</span><span class="p">].</span><span class="nx">swfVersion</span><span class="p">)</span><span class="o">&amp;&amp;!</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">wk</span><span class="o">&amp;&amp;</span><span class="nx">M</span><span class="p">.</span><span class="nx">wk</span><span class="o">&lt;</span><span class="mi">312</span><span class="p">)){</span><span class="nx">w</span><span class="p">(</span><span class="nx">Y</span><span class="p">,</span><span class="kc">true</span><span class="p">);</span><span class="k">if</span><span class="p">(</span><span class="nx">ab</span><span class="p">){</span><span class="nx">aa</span><span class="p">.</span><span class="nx">success</span><span class="o">=</span><span class="kc">true</span><span class="p">;</span><span class="nx">aa</span><span class="p">.</span><span class="nx">ref</span><span class="o">=</span><span class="nx">z</span><span class="p">(</span><span class="nx">Y</span><span class="p">);</span><span class="nx">ab</span><span class="p">(</span><span class="nx">aa</span><span class="p">)}}</span><span class="k">else</span><span class="p">{</span><span class="k">if</span><span class="p">(</span><span class="nx">o</span><span class="p">[</span><span class="nx">af</span><span class="p">].</span><span class="nx">expressInstall</span><span class="o">&amp;&amp;</span><span class="nx">A</span><span class="p">()){</span><span class="kd">var</span> <span class="nx">ai</span><span class="o">=</span><span class="p">{};</span><span class="nx">ai</span><span class="p">.</span><span class="nx">data</span><span class="o">=</span><span class="nx">o</span><span class="p">[</span><span class="nx">af</span><span class="p">].</span><span class="nx">expressInstall</span><span class="p">;</span><span class="nx">ai</span><span class="p">.</span><span class="nx">width</span><span class="o">=</span><span class="nx">ae</span><span class="p">.</span><span class="nx">getAttribute</span><span class="p">(</span><span class="s2">&quot;width&quot;</span><span class="p">)</span><span class="o">||</span><span class="s2">&quot;0&quot;</span><span class="p">;</span><span class="nx">ai</span><span class="p">.</span><span class="nx">height</span><span class="o">=</span><span class="nx">ae</span><span class="p">.</span><span class="nx">getAttribute</span><span class="p">(</span><span class="s2">&quot;height&quot;</span><span class="p">)</span><span class="o">||</span><span class="s2">&quot;0&quot;</span><span class="p">;</span><span class="k">if</span><span class="p">(</span><span class="nx">ae</span><span class="p">.</span><span class="nx">getAttribute</span><span class="p">(</span><span class="s2">&quot;class&quot;</span><span class="p">)){</span><span class="nx">ai</span><span class="p">.</span><span class="nx">styleclass</span><span class="o">=</span><span class="nx">ae</span><span class="p">.</span><span class="nx">getAttribute</span><span class="p">(</span><span class="s2">&quot;class&quot;</span><span class="p">)}</span><span class="k">if</span><span class="p">(</span><span class="nx">ae</span><span class="p">.</span><span class="nx">getAttribute</span><span class="p">(</span><span class="s2">&quot;align&quot;</span><span class="p">)){</span><span class="nx">ai</span><span class="p">.</span><span class="nx">align</span><span class="o">=</span><span class="nx">ae</span><span class="p">.</span><span class="nx">getAttribute</span><span class="p">(</span><span class="s2">&quot;align&quot;</span><span class="p">)}</span><span class="kd">var</span> <span class="nx">ah</span><span class="o">=</span><span class="p">{};</span><span class="kd">var</span> <span class="nx">X</span><span class="o">=</span><span class="nx">ae</span><span class="p">.</span><span class="nx">getElementsByTagName</span><span class="p">(</span><span class="s2">&quot;param&quot;</span><span class="p">);</span><span class="kd">var</span> <span class="nx">ac</span><span class="o">=</span><span class="nx">X</span><span class="p">.</span><span class="nx">length</span><span class="p">;</span><span class="k">for</span><span class="p">(</span><span class="kd">var</span> <span class="nx">ad</span><span class="o">=</span><span class="mi">0</span><span class="p">;</span><span class="nx">ad</span><span class="o">&lt;</span><span class="nx">ac</span><span class="p">;</span><span class="nx">ad</span><span class="o">++</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="nx">X</span><span class="p">[</span><span class="nx">ad</span><span class="p">].</span><span class="nx">getAttribute</span><span class="p">(</span><span class="s2">&quot;name&quot;</span><span class="p">).</span><span class="nx">toLowerCase</span><span class="p">()</span><span class="o">!=</span><span class="s2">&quot;movie&quot;</span><span class="p">){</span><span class="nx">ah</span><span class="p">[</span><span class="nx">X</span><span class="p">[</span><span class="nx">ad</span><span class="p">].</span><span class="nx">getAttribute</span><span class="p">(</span><span class="s2">&quot;name&quot;</span><span class="p">)]</span><span class="o">=</span><span class="nx">X</span><span class="p">[</span><span class="nx">ad</span><span class="p">].</span><span class="nx">getAttribute</span><span class="p">(</span><span class="s2">&quot;value&quot;</span><span class="p">)}}</span><span class="nx">P</span><span class="p">(</span><span class="nx">ai</span><span class="p">,</span><span class="nx">ah</span><span class="p">,</span><span class="nx">Y</span><span class="p">,</span><span class="nx">ab</span><span class="p">)}</span><span class="k">else</span><span class="p">{</span><span class="nx">p</span><span class="p">(</span><span class="nx">ae</span><span class="p">);</span><span class="k">if</span><span class="p">(</span><span class="nx">ab</span><span class="p">){</span><span class="nx">ab</span><span class="p">(</span><span class="nx">aa</span><span class="p">)}}}}}</span><span class="k">else</span><span class="p">{</span><span class="nx">w</span><span class="p">(</span><span class="nx">Y</span><span class="p">,</span><span class="kc">true</span><span class="p">);</span><span class="k">if</span><span class="p">(</span><span class="nx">ab</span><span class="p">){</span><span class="kd">var</span> <span class="nx">Z</span><span class="o">=</span><span class="nx">z</span><span class="p">(</span><span class="nx">Y</span><span class="p">);</span><span class="k">if</span><span class="p">(</span><span class="nx">Z</span><span class="o">&amp;&amp;</span><span class="k">typeof</span> <span class="nx">Z</span><span class="p">.</span><span class="nx">SetVariable</span><span class="o">!=</span><span class="nx">D</span><span class="p">){</span><span class="nx">aa</span><span class="p">.</span><span class="nx">success</span><span class="o">=</span><span class="kc">true</span><span class="p">;</span><span class="nx">aa</span><span class="p">.</span><span class="nx">ref</span><span class="o">=</span><span class="nx">Z</span><span class="p">}</span><span class="nx">ab</span><span class="p">(</span><span class="nx">aa</span><span class="p">)}}}}}</span><span class="kd">function</span> <span class="nx">z</span><span class="p">(</span><span class="nx">aa</span><span class="p">){</span><span class="kd">var</span> <span class="nx">X</span><span class="o">=</span><span class="kc">null</span><span class="p">;</span><span class="kd">var</span> <span class="nx">Y</span><span class="o">=</span><span class="nx">c</span><span class="p">(</span><span class="nx">aa</span><span class="p">);</span><span class="k">if</span><span class="p">(</span><span class="nx">Y</span><span class="o">&amp;&amp;</span><span class="nx">Y</span><span class="p">.</span><span class="nx">nodeName</span><span class="o">==</span><span class="s2">&quot;OBJECT&quot;</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="k">typeof</span> <span class="nx">Y</span><span class="p">.</span><span class="nx">SetVariable</span><span class="o">!=</span><span class="nx">D</span><span class="p">){</span><span class="nx">X</span><span class="o">=</span><span class="nx">Y</span><span class="p">}</span><span class="k">else</span><span class="p">{</span><span class="kd">var</span> <span class="nx">Z</span><span class="o">=</span><span class="nx">Y</span><span class="p">.</span><span class="nx">getElementsByTagName</span><span class="p">(</span><span class="nx">r</span><span class="p">)[</span><span class="mi">0</span><span class="p">];</span><span class="k">if</span><span class="p">(</span><span class="nx">Z</span><span class="p">){</span><span class="nx">X</span><span class="o">=</span><span class="nx">Z</span><span class="p">}}}</span><span class="k">return</span> <span class="nx">X</span><span class="p">}</span><span class="kd">function</span> <span class="nx">A</span><span class="p">(){</span><span class="k">return</span> <span class="o">!</span><span class="nx">a</span><span class="o">&amp;&amp;</span><span class="nx">F</span><span class="p">(</span><span class="s2">&quot;6.0.65&quot;</span><span class="p">)</span><span class="o">&amp;&amp;</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">win</span><span class="o">||</span><span class="nx">M</span><span class="p">.</span><span class="nx">mac</span><span class="p">)</span><span class="o">&amp;&amp;!</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">wk</span><span class="o">&amp;&amp;</span><span class="nx">M</span><span class="p">.</span><span class="nx">wk</span><span class="o">&lt;</span><span class="mi">312</span><span class="p">)}</span><span class="kd">function</span> <span class="nx">P</span><span class="p">(</span><span class="nx">aa</span><span class="p">,</span><span class="nx">ab</span><span class="p">,</span><span class="nx">X</span><span class="p">,</span><span class="nx">Z</span><span class="p">){</span><span class="nx">a</span><span class="o">=</span><span class="kc">true</span><span class="p">;</span><span class="nx">E</span><span class="o">=</span><span class="nx">Z</span><span class="o">||</span><span class="kc">null</span><span class="p">;</span><span class="nx">B</span><span class="o">=</span><span class="p">{</span><span class="nx">success</span><span class="o">:</span><span class="kc">false</span><span class="p">,</span><span class="nx">id</span><span class="o">:</span><span class="nx">X</span><span class="p">};</span><span class="kd">var</span> <span class="nx">ae</span><span class="o">=</span><span class="nx">c</span><span class="p">(</span><span class="nx">X</span><span class="p">);</span><span class="k">if</span><span class="p">(</span><span class="nx">ae</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="nx">ae</span><span class="p">.</span><span class="nx">nodeName</span><span class="o">==</span><span class="s2">&quot;OBJECT&quot;</span><span class="p">){</span><span class="nx">l</span><span class="o">=</span><span class="nx">g</span><span class="p">(</span><span class="nx">ae</span><span class="p">);</span><span class="nx">Q</span><span class="o">=</span><span class="kc">null</span><span class="p">}</span><span class="k">else</span><span class="p">{</span><span class="nx">l</span><span class="o">=</span><span class="nx">ae</span><span class="p">;</span><span class="nx">Q</span><span class="o">=</span><span class="nx">X</span><span class="p">}</span><span class="nx">aa</span><span class="p">.</span><span class="nx">id</span><span class="o">=</span><span class="nx">R</span><span class="p">;</span><span class="k">if</span><span class="p">(</span><span class="k">typeof</span> <span class="nx">aa</span><span class="p">.</span><span class="nx">width</span><span class="o">==</span><span class="nx">D</span><span class="o">||</span><span class="p">(</span><span class="o">!</span><span class="sr">/%$/</span><span class="p">.</span><span class="nx">test</span><span class="p">(</span><span class="nx">aa</span><span class="p">.</span><span class="nx">width</span><span class="p">)</span><span class="o">&amp;&amp;</span><span class="nb">parseInt</span><span class="p">(</span><span class="nx">aa</span><span class="p">.</span><span class="nx">width</span><span class="p">,</span><span class="mi">10</span><span class="p">)</span><span class="o">&lt;</span><span class="mi">310</span><span class="p">)){</span><span class="nx">aa</span><span class="p">.</span><span class="nx">width</span><span class="o">=</span><span class="s2">&quot;310&quot;</span><span class="p">}</span><span class="k">if</span><span class="p">(</span><span class="k">typeof</span> <span class="nx">aa</span><span class="p">.</span><span class="nx">height</span><span class="o">==</span><span class="nx">D</span><span class="o">||</span><span class="p">(</span><span class="o">!</span><span class="sr">/%$/</span><span class="p">.</span><span class="nx">test</span><span class="p">(</span><span class="nx">aa</span><span class="p">.</span><span class="nx">height</span><span class="p">)</span><span class="o">&amp;&amp;</span><span class="nb">parseInt</span><span class="p">(</span><span class="nx">aa</span><span class="p">.</span><span class="nx">height</span><span class="p">,</span><span class="mi">10</span><span class="p">)</span><span class="o">&lt;</span><span class="mi">137</span><span class="p">)){</span><span class="nx">aa</span><span class="p">.</span><span class="nx">height</span><span class="o">=</span><span class="s2">&quot;137&quot;</span><span class="p">}</span><span class="nx">j</span><span class="p">.</span><span class="nx">title</span><span class="o">=</span><span class="nx">j</span><span class="p">.</span><span class="nx">title</span><span class="p">.</span><span class="nx">slice</span><span class="p">(</span><span class="mi">0</span><span class="p">,</span><span class="mi">47</span><span class="p">)</span><span class="o">+</span><span class="s2">&quot; - Flash Player Installation&quot;</span><span class="p">;</span><span class="kd">var</span> <span class="nx">ad</span><span class="o">=</span><span class="nx">M</span><span class="p">.</span><span class="nx">ie</span><span class="o">&amp;&amp;</span><span class="nx">M</span><span class="p">.</span><span class="nx">win</span><span class="o">?</span><span class="s2">&quot;ActiveX&quot;</span><span class="o">:</span><span class="s2">&quot;PlugIn&quot;</span><span class="p">,</span><span class="nx">ac</span><span class="o">=</span><span class="s2">&quot;MMredirectURL=&quot;</span><span class="o">+</span><span class="nx">O</span><span class="p">.</span><span class="nx">location</span><span class="p">.</span><span class="nx">toString</span><span class="p">().</span><span class="nx">replace</span><span class="p">(</span><span class="sr">/&amp;/g</span><span class="p">,</span><span class="s2">&quot;%26&quot;</span><span class="p">)</span><span class="o">+</span><span class="s2">&quot;&amp;MMplayerType=&quot;</span><span class="o">+</span><span class="nx">ad</span><span class="o">+</span><span class="s2">&quot;&amp;MMdoctitle=&quot;</span><span class="o">+</span><span class="nx">j</span><span class="p">.</span><span class="nx">title</span><span class="p">;</span><span class="k">if</span><span class="p">(</span><span class="k">typeof</span> <span class="nx">ab</span><span class="p">.</span><span class="nx">flashvars</span><span class="o">!=</span><span class="nx">D</span><span class="p">){</span><span class="nx">ab</span><span class="p">.</span><span class="nx">flashvars</span><span class="o">+=</span><span class="s2">&quot;&amp;&quot;</span><span class="o">+</span><span class="nx">ac</span><span class="p">}</span><span class="k">else</span><span class="p">{</span><span class="nx">ab</span><span class="p">.</span><span class="nx">flashvars</span><span class="o">=</span><span class="nx">ac</span><span class="p">}</span><span class="k">if</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">ie</span><span class="o">&amp;&amp;</span><span class="nx">M</span><span class="p">.</span><span class="nx">win</span><span class="o">&amp;&amp;</span><span class="nx">ae</span><span class="p">.</span><span class="nx">readyState</span><span class="o">!=</span><span class="mi">4</span><span class="p">){</span><span class="kd">var</span> <span class="nx">Y</span><span class="o">=</span><span class="nx">C</span><span class="p">(</span><span class="s2">&quot;div&quot;</span><span class="p">);</span><span class="nx">X</span><span class="o">+=</span><span class="s2">&quot;SWFObjectNew&quot;</span><span class="p">;</span><span class="nx">Y</span><span class="p">.</span><span class="nx">setAttribute</span><span class="p">(</span><span class="s2">&quot;id&quot;</span><span class="p">,</span><span class="nx">X</span><span class="p">);</span><span class="nx">ae</span><span class="p">.</span><span class="nx">parentNode</span><span class="p">.</span><span class="nx">insertBefore</span><span class="p">(</span><span class="nx">Y</span><span class="p">,</span><span class="nx">ae</span><span class="p">);</span><span class="nx">ae</span><span class="p">.</span><span class="nx">style</span><span class="p">.</span><span class="nx">display</span><span class="o">=</span><span class="s2">&quot;none&quot;</span><span class="p">;(</span><span class="kd">function</span><span class="p">(){</span><span class="k">if</span><span class="p">(</span><span class="nx">ae</span><span class="p">.</span><span class="nx">readyState</span><span class="o">==</span><span class="mi">4</span><span class="p">){</span><span class="nx">ae</span><span class="p">.</span><span class="nx">parentNode</span><span class="p">.</span><span class="nx">removeChild</span><span class="p">(</span><span class="nx">ae</span><span class="p">)}</span><span class="k">else</span><span class="p">{</span><span class="nx">setTimeout</span><span class="p">(</span><span class="nx">arguments</span><span class="p">.</span><span class="nx">callee</span><span class="p">,</span><span class="mi">10</span><span class="p">)}})()}</span><span class="nx">u</span><span class="p">(</span><span class="nx">aa</span><span class="p">,</span><span class="nx">ab</span><span class="p">,</span><span class="nx">X</span><span class="p">)}}</span><span class="kd">function</span> <span class="nx">p</span><span class="p">(</span><span class="nx">Y</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">ie</span><span class="o">&amp;&amp;</span><span class="nx">M</span><span class="p">.</span><span class="nx">win</span><span class="o">&amp;&amp;</span><span class="nx">Y</span><span class="p">.</span><span class="nx">readyState</span><span class="o">!=</span><span class="mi">4</span><span class="p">){</span><span class="kd">var</span> <span class="nx">X</span><span class="o">=</span><span class="nx">C</span><span class="p">(</span><span class="s2">&quot;div&quot;</span><span class="p">);</span><span class="nx">Y</span><span class="p">.</span><span class="nx">parentNode</span><span class="p">.</span><span class="nx">insertBefore</span><span class="p">(</span><span class="nx">X</span><span class="p">,</span><span class="nx">Y</span><span class="p">);</span><span class="nx">X</span><span class="p">.</span><span class="nx">parentNode</span><span class="p">.</span><span class="nx">replaceChild</span><span class="p">(</span><span class="nx">g</span><span class="p">(</span><span class="nx">Y</span><span class="p">),</span><span class="nx">X</span><span class="p">);</span><span class="nx">Y</span><span class="p">.</span><span class="nx">style</span><span class="p">.</span><span class="nx">display</span><span class="o">=</span><span class="s2">&quot;none&quot;</span><span class="p">;(</span><span class="kd">function</span><span class="p">(){</span><span class="k">if</span><span class="p">(</span><span class="nx">Y</span><span class="p">.</span><span class="nx">readyState</span><span class="o">==</span><span class="mi">4</span><span class="p">){</span><span class="nx">Y</span><span class="p">.</span><span class="nx">parentNode</span><span class="p">.</span><span class="nx">removeChild</span><span class="p">(</span><span class="nx">Y</span><span class="p">)}</span><span class="k">else</span><span class="p">{</span><span class="nx">setTimeout</span><span class="p">(</span><span class="nx">arguments</span><span class="p">.</span><span class="nx">callee</span><span class="p">,</span><span class="mi">10</span><span class="p">)}})()}</span><span class="k">else</span><span class="p">{</span><span class="nx">Y</span><span class="p">.</span><span class="nx">parentNode</span><span class="p">.</span><span class="nx">replaceChild</span><span class="p">(</span><span class="nx">g</span><span class="p">(</span><span class="nx">Y</span><span class="p">),</span><span class="nx">Y</span><span class="p">)}}</span><span class="kd">function</span> <span class="nx">g</span><span class="p">(</span><span class="nx">ab</span><span class="p">){</span><span class="kd">var</span> <span class="nx">aa</span><span class="o">=</span><span class="nx">C</span><span class="p">(</span><span class="s2">&quot;div&quot;</span><span class="p">);</span><span class="k">if</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">win</span><span class="o">&amp;&amp;</span><span class="nx">M</span><span class="p">.</span><span class="nx">ie</span><span class="p">){</span><span class="nx">aa</span><span class="p">.</span><span class="nx">innerHTML</span><span class="o">=</span><span class="nx">ab</span><span class="p">.</span><span class="nx">innerHTML</span><span class="p">}</span><span class="k">else</span><span class="p">{</span><span class="kd">var</span> <span class="nx">Y</span><span class="o">=</span><span class="nx">ab</span><span class="p">.</span><span class="nx">getElementsByTagName</span><span class="p">(</span><span class="nx">r</span><span class="p">)[</span><span class="mi">0</span><span class="p">];</span><span class="k">if</span><span class="p">(</span><span class="nx">Y</span><span class="p">){</span><span class="kd">var</span> <span class="nx">ad</span><span class="o">=</span><span class="nx">Y</span><span class="p">.</span><span class="nx">childNodes</span><span class="p">;</span><span class="k">if</span><span class="p">(</span><span class="nx">ad</span><span class="p">){</span><span class="kd">var</span> <span class="nx">X</span><span class="o">=</span><span class="nx">ad</span><span class="p">.</span><span class="nx">length</span><span class="p">;</span><span class="k">for</span><span class="p">(</span><span class="kd">var</span> <span class="nx">Z</span><span class="o">=</span><span class="mi">0</span><span class="p">;</span><span class="nx">Z</span><span class="o">&lt;</span><span class="nx">X</span><span class="p">;</span><span class="nx">Z</span><span class="o">++</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="o">!</span><span class="p">(</span><span class="nx">ad</span><span class="p">[</span><span class="nx">Z</span><span class="p">].</span><span class="nx">nodeType</span><span class="o">==</span><span class="mi">1</span><span class="o">&amp;&amp;</span><span class="nx">ad</span><span class="p">[</span><span class="nx">Z</span><span class="p">].</span><span class="nx">nodeName</span><span class="o">==</span><span class="s2">&quot;PARAM&quot;</span><span class="p">)</span><span class="o">&amp;&amp;!</span><span class="p">(</span><span class="nx">ad</span><span class="p">[</span><span class="nx">Z</span><span class="p">].</span><span class="nx">nodeType</span><span class="o">==</span><span class="mi">8</span><span class="p">)){</span><span class="nx">aa</span><span class="p">.</span><span class="nx">appendChild</span><span class="p">(</span><span class="nx">ad</span><span class="p">[</span><span class="nx">Z</span><span class="p">].</span><span class="nx">cloneNode</span><span class="p">(</span><span class="kc">true</span><span class="p">))}}}}}</span><span class="k">return</span> <span class="nx">aa</span><span class="p">}</span><span class="kd">function</span> <span class="nx">u</span><span class="p">(</span><span class="nx">ai</span><span class="p">,</span><span class="nx">ag</span><span class="p">,</span><span class="nx">Y</span><span class="p">){</span><span class="kd">var</span> <span class="nx">X</span><span class="p">,</span><span class="nx">aa</span><span class="o">=</span><span class="nx">c</span><span class="p">(</span><span class="nx">Y</span><span class="p">);</span><span class="k">if</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">wk</span><span class="o">&amp;&amp;</span><span class="nx">M</span><span class="p">.</span><span class="nx">wk</span><span class="o">&lt;</span><span class="mi">312</span><span class="p">){</span><span class="k">return</span> <span class="nx">X</span><span class="p">}</span><span class="k">if</span><span class="p">(</span><span class="nx">aa</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="k">typeof</span> <span class="nx">ai</span><span class="p">.</span><span class="nx">id</span><span class="o">==</span><span class="nx">D</span><span class="p">){</span><span class="nx">ai</span><span class="p">.</span><span class="nx">id</span><span class="o">=</span><span class="nx">Y</span><span class="p">}</span><span class="k">if</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">ie</span><span class="o">&amp;&amp;</span><span class="nx">M</span><span class="p">.</span><span class="nx">win</span><span class="p">){</span><span class="kd">var</span> <span class="nx">ah</span><span class="o">=</span><span class="s2">&quot;&quot;</span><span class="p">;</span><span class="k">for</span><span class="p">(</span><span class="kd">var</span> <span class="nx">ae</span> <span class="k">in</span> <span class="nx">ai</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="nx">ai</span><span class="p">[</span><span class="nx">ae</span><span class="p">]</span><span class="o">!=</span><span class="nb">Object</span><span class="p">.</span><span class="nx">prototype</span><span class="p">[</span><span class="nx">ae</span><span class="p">]){</span><span class="k">if</span><span class="p">(</span><span class="nx">ae</span><span class="p">.</span><span class="nx">toLowerCase</span><span class="p">()</span><span class="o">==</span><span class="s2">&quot;data&quot;</span><span class="p">){</span><span class="nx">ag</span><span class="p">.</span><span class="nx">movie</span><span class="o">=</span><span class="nx">ai</span><span class="p">[</span><span class="nx">ae</span><span class="p">]}</span><span class="k">else</span><span class="p">{</span><span class="k">if</span><span class="p">(</span><span class="nx">ae</span><span class="p">.</span><span class="nx">toLowerCase</span><span class="p">()</span><span class="o">==</span><span class="s2">&quot;styleclass&quot;</span><span class="p">){</span><span class="nx">ah</span><span class="o">+=</span><span class="s1">&#39; class=&quot;&#39;</span><span class="o">+</span><span class="nx">ai</span><span class="p">[</span><span class="nx">ae</span><span class="p">]</span><span class="o">+</span><span class="s1">&#39;&quot;&#39;</span><span class="p">}</span><span class="k">else</span><span class="p">{</span><span class="k">if</span><span class="p">(</span><span class="nx">ae</span><span class="p">.</span><span class="nx">toLowerCase</span><span class="p">()</span><span class="o">!=</span><span class="s2">&quot;classid&quot;</span><span class="p">){</span><span class="nx">ah</span><span class="o">+=</span><span class="s2">&quot; &quot;</span><span class="o">+</span><span class="nx">ae</span><span class="o">+</span><span class="s1">&#39;=&quot;&#39;</span><span class="o">+</span><span class="nx">ai</span><span class="p">[</span><span class="nx">ae</span><span class="p">]</span><span class="o">+</span><span class="s1">&#39;&quot;&#39;</span><span class="p">}}}}}</span><span class="kd">var</span> <span class="nx">af</span><span class="o">=</span><span class="s2">&quot;&quot;</span><span class="p">;</span><span class="k">for</span><span class="p">(</span><span class="kd">var</span> <span class="nx">ad</span> <span class="k">in</span> <span class="nx">ag</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="nx">ag</span><span class="p">[</span><span class="nx">ad</span><span class="p">]</span><span class="o">!=</span><span class="nb">Object</span><span class="p">.</span><span class="nx">prototype</span><span class="p">[</span><span class="nx">ad</span><span class="p">]){</span><span class="nx">af</span><span class="o">+=</span><span class="s1">&#39;&lt;param name=&quot;&#39;</span><span class="o">+</span><span class="nx">ad</span><span class="o">+</span><span class="s1">&#39;&quot; value=&quot;&#39;</span><span class="o">+</span><span class="nx">ag</span><span class="p">[</span><span class="nx">ad</span><span class="p">]</span><span class="o">+</span><span class="s1">&#39;&quot; /&gt;&#39;</span><span class="p">}}</span><span class="nx">aa</span><span class="p">.</span><span class="nx">outerHTML</span><span class="o">=</span><span class="s1">&#39;&lt;object classid=&quot;clsid:D27CDB6E-AE6D-11cf-96B8-444553540000&quot;&#39;</span><span class="o">+</span><span class="nx">ah</span><span class="o">+</span><span class="s2">&quot;&gt;&quot;</span><span class="o">+</span><span class="nx">af</span><span class="o">+</span><span class="s2">&quot;&lt;/object&gt;&quot;</span><span class="p">;</span><span class="nx">N</span><span class="p">[</span><span class="nx">N</span><span class="p">.</span><span class="nx">length</span><span class="p">]</span><span class="o">=</span><span class="nx">ai</span><span class="p">.</span><span class="nx">id</span><span class="p">;</span><span class="nx">X</span><span class="o">=</span><span class="nx">c</span><span class="p">(</span><span class="nx">ai</span><span class="p">.</span><span class="nx">id</span><span class="p">)}</span><span class="k">else</span><span class="p">{</span><span class="kd">var</span> <span class="nx">Z</span><span class="o">=</span><span class="nx">C</span><span class="p">(</span><span class="nx">r</span><span class="p">);</span><span class="nx">Z</span><span class="p">.</span><span class="nx">setAttribute</span><span class="p">(</span><span class="s2">&quot;type&quot;</span><span class="p">,</span><span class="nx">q</span><span class="p">);</span><span class="k">for</span><span class="p">(</span><span class="kd">var</span> <span class="nx">ac</span> <span class="k">in</span> <span class="nx">ai</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="nx">ai</span><span class="p">[</span><span class="nx">ac</span><span class="p">]</span><span class="o">!=</span><span class="nb">Object</span><span class="p">.</span><span class="nx">prototype</span><span class="p">[</span><span class="nx">ac</span><span class="p">]){</span><span class="k">if</span><span class="p">(</span><span class="nx">ac</span><span class="p">.</span><span class="nx">toLowerCase</span><span class="p">()</span><span class="o">==</span><span class="s2">&quot;styleclass&quot;</span><span class="p">){</span><span class="nx">Z</span><span class="p">.</span><span class="nx">setAttribute</span><span class="p">(</span><span class="s2">&quot;class&quot;</span><span class="p">,</span><span class="nx">ai</span><span class="p">[</span><span class="nx">ac</span><span class="p">])}</span><span class="k">else</span><span class="p">{</span><span class="k">if</span><span class="p">(</span><span class="nx">ac</span><span class="p">.</span><span class="nx">toLowerCase</span><span class="p">()</span><span class="o">!=</span><span class="s2">&quot;classid&quot;</span><span class="p">){</span><span class="nx">Z</span><span class="p">.</span><span class="nx">setAttribute</span><span class="p">(</span><span class="nx">ac</span><span class="p">,</span><span class="nx">ai</span><span class="p">[</span><span class="nx">ac</span><span class="p">])}}}}</span><span class="k">for</span><span class="p">(</span><span class="kd">var</span> <span class="nx">ab</span> <span class="k">in</span> <span class="nx">ag</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="nx">ag</span><span class="p">[</span><span class="nx">ab</span><span class="p">]</span><span class="o">!=</span><span class="nb">Object</span><span class="p">.</span><span class="nx">prototype</span><span class="p">[</span><span class="nx">ab</span><span class="p">]</span><span class="o">&amp;&amp;</span><span class="nx">ab</span><span class="p">.</span><span class="nx">toLowerCase</span><span class="p">()</span><span class="o">!=</span><span class="s2">&quot;movie&quot;</span><span class="p">){</span><span class="nx">e</span><span class="p">(</span><span class="nx">Z</span><span class="p">,</span><span class="nx">ab</span><span class="p">,</span><span class="nx">ag</span><span class="p">[</span><span class="nx">ab</span><span class="p">])}}</span><span class="nx">aa</span><span class="p">.</span><span class="nx">parentNode</span><span class="p">.</span><span class="nx">replaceChild</span><span class="p">(</span><span class="nx">Z</span><span class="p">,</span><span class="nx">aa</span><span class="p">);</span><span class="nx">X</span><span class="o">=</span><span class="nx">Z</span><span class="p">}}</span><span class="k">return</span> <span class="nx">X</span><span class="p">}</span><span class="kd">function</span> <span class="nx">e</span><span class="p">(</span><span class="nx">Z</span><span class="p">,</span><span class="nx">X</span><span class="p">,</span><span class="nx">Y</span><span class="p">){</span><span class="kd">var</span> <span class="nx">aa</span><span class="o">=</span><span class="nx">C</span><span class="p">(</span><span class="s2">&quot;param&quot;</span><span class="p">);</span><span class="nx">aa</span><span class="p">.</span><span class="nx">setAttribute</span><span class="p">(</span><span class="s2">&quot;name&quot;</span><span class="p">,</span><span class="nx">X</span><span class="p">);</span><span class="nx">aa</span><span class="p">.</span><span class="nx">setAttribute</span><span class="p">(</span><span class="s2">&quot;value&quot;</span><span class="p">,</span><span class="nx">Y</span><span class="p">);</span><span class="nx">Z</span><span class="p">.</span><span class="nx">appendChild</span><span class="p">(</span><span class="nx">aa</span><span class="p">)}</span><span class="kd">function</span> <span class="nx">y</span><span class="p">(</span><span class="nx">Y</span><span class="p">){</span><span class="kd">var</span> <span class="nx">X</span><span class="o">=</span><span class="nx">c</span><span class="p">(</span><span class="nx">Y</span><span class="p">);</span><span class="k">if</span><span class="p">(</span><span class="nx">X</span><span class="o">&amp;&amp;</span><span class="nx">X</span><span class="p">.</span><span class="nx">nodeName</span><span class="o">==</span><span class="s2">&quot;OBJECT&quot;</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">ie</span><span class="o">&amp;&amp;</span><span class="nx">M</span><span class="p">.</span><span class="nx">win</span><span class="p">){</span><span class="nx">X</span><span class="p">.</span><span class="nx">style</span><span class="p">.</span><span class="nx">display</span><span class="o">=</span><span class="s2">&quot;none&quot;</span><span class="p">;(</span><span class="kd">function</span><span class="p">(){</span><span class="k">if</span><span class="p">(</span><span class="nx">X</span><span class="p">.</span><span class="nx">readyState</span><span class="o">==</span><span class="mi">4</span><span class="p">){</span><span class="nx">b</span><span class="p">(</span><span class="nx">Y</span><span class="p">)}</span><span class="k">else</span><span class="p">{</span><span class="nx">setTimeout</span><span class="p">(</span><span class="nx">arguments</span><span class="p">.</span><span class="nx">callee</span><span class="p">,</span><span class="mi">10</span><span class="p">)}})()}</span><span class="k">else</span><span class="p">{</span><span class="nx">X</span><span class="p">.</span><span class="nx">parentNode</span><span class="p">.</span><span class="nx">removeChild</span><span class="p">(</span><span class="nx">X</span><span class="p">)}}}</span><span class="kd">function</span> <span class="nx">b</span><span class="p">(</span><span class="nx">Z</span><span class="p">){</span><span class="kd">var</span> <span class="nx">Y</span><span class="o">=</span><span class="nx">c</span><span class="p">(</span><span class="nx">Z</span><span class="p">);</span><span class="k">if</span><span class="p">(</span><span class="nx">Y</span><span class="p">){</span><span class="k">for</span><span class="p">(</span><span class="kd">var</span> <span class="nx">X</span> <span class="k">in</span> <span class="nx">Y</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="k">typeof</span> <span class="nx">Y</span><span class="p">[</span><span class="nx">X</span><span class="p">]</span><span class="o">==</span><span class="s2">&quot;function&quot;</span><span class="p">){</span><span class="nx">Y</span><span class="p">[</span><span class="nx">X</span><span class="p">]</span><span class="o">=</span><span class="kc">null</span><span class="p">}}</span><span class="nx">Y</span><span class="p">.</span><span class="nx">parentNode</span><span class="p">.</span><span class="nx">removeChild</span><span class="p">(</span><span class="nx">Y</span><span class="p">)}}</span><span class="kd">function</span> <span class="nx">c</span><span class="p">(</span><span class="nx">Z</span><span class="p">){</span><span class="kd">var</span> <span class="nx">X</span><span class="o">=</span><span class="kc">null</span><span class="p">;</span><span class="k">try</span><span class="p">{</span><span class="nx">X</span><span class="o">=</span><span class="nx">j</span><span class="p">.</span><span class="nx">getElementById</span><span class="p">(</span><span class="nx">Z</span><span class="p">)}</span><span class="k">catch</span><span class="p">(</span><span class="nx">Y</span><span class="p">){}</span><span class="k">return</span> <span class="nx">X</span><span class="p">}</span><span class="kd">function</span> <span class="nx">C</span><span class="p">(</span><span class="nx">X</span><span class="p">){</span><span class="k">return</span> <span class="nx">j</span><span class="p">.</span><span class="nx">createElement</span><span class="p">(</span><span class="nx">X</span><span class="p">)}</span><span class="kd">function</span> <span class="nx">i</span><span class="p">(</span><span class="nx">Z</span><span class="p">,</span><span class="nx">X</span><span class="p">,</span><span class="nx">Y</span><span class="p">){</span><span class="nx">Z</span><span class="p">.</span><span class="nx">attachEvent</span><span class="p">(</span><span class="nx">X</span><span class="p">,</span><span class="nx">Y</span><span class="p">);</span><span class="nx">I</span><span class="p">[</span><span class="nx">I</span><span class="p">.</span><span class="nx">length</span><span class="p">]</span><span class="o">=</span><span class="p">[</span><span class="nx">Z</span><span class="p">,</span><span class="nx">X</span><span class="p">,</span><span class="nx">Y</span><span class="p">]}</span><span class="kd">function</span> <span class="nx">F</span><span class="p">(</span><span class="nx">Z</span><span class="p">){</span><span class="kd">var</span> <span class="nx">Y</span><span class="o">=</span><span class="nx">M</span><span class="p">.</span><span class="nx">pv</span><span class="p">,</span><span class="nx">X</span><span class="o">=</span><span class="nx">Z</span><span class="p">.</span><span class="nx">split</span><span class="p">(</span><span class="s2">&quot;.&quot;</span><span class="p">);</span><span class="nx">X</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span><span class="o">=</span><span class="nb">parseInt</span><span class="p">(</span><span class="nx">X</span><span class="p">[</span><span class="mi">0</span><span class="p">],</span><span class="mi">10</span><span class="p">);</span><span class="nx">X</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span><span class="o">=</span><span class="nb">parseInt</span><span class="p">(</span><span class="nx">X</span><span class="p">[</span><span class="mi">1</span><span class="p">],</span><span class="mi">10</span><span class="p">)</span><span class="o">||</span><span class="mi">0</span><span class="p">;</span><span class="nx">X</span><span class="p">[</span><span class="mi">2</span><span class="p">]</span><span class="o">=</span><span class="nb">parseInt</span><span class="p">(</span><span class="nx">X</span><span class="p">[</span><span class="mi">2</span><span class="p">],</span><span class="mi">10</span><span class="p">)</span><span class="o">||</span><span class="mi">0</span><span class="p">;</span><span class="k">return</span><span class="p">(</span><span class="nx">Y</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span><span class="o">&gt;</span><span class="nx">X</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span><span class="o">||</span><span class="p">(</span><span class="nx">Y</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span><span class="o">==</span><span class="nx">X</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span><span class="o">&amp;&amp;</span><span class="nx">Y</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span><span class="o">&gt;</span><span class="nx">X</span><span class="p">[</span><span class="mi">1</span><span class="p">])</span><span class="o">||</span><span class="p">(</span><span class="nx">Y</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span><span class="o">==</span><span class="nx">X</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span><span class="o">&amp;&amp;</span><span class="nx">Y</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span><span class="o">==</span><span class="nx">X</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span><span class="o">&amp;&amp;</span><span class="nx">Y</span><span class="p">[</span><span class="mi">2</span><span class="p">]</span><span class="o">&gt;=</span><span class="nx">X</span><span class="p">[</span><span class="mi">2</span><span class="p">]))</span><span class="o">?</span><span class="kc">true</span><span class="o">:</span><span class="kc">false</span><span class="p">}</span><span class="kd">function</span> <span class="nx">v</span><span class="p">(</span><span class="nx">ac</span><span class="p">,</span><span class="nx">Y</span><span class="p">,</span><span class="nx">ad</span><span class="p">,</span><span class="nx">ab</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">ie</span><span class="o">&amp;&amp;</span><span class="nx">M</span><span class="p">.</span><span class="nx">mac</span><span class="p">){</span><span class="k">return</span><span class="p">}</span><span class="kd">var</span> <span class="nx">aa</span><span class="o">=</span><span class="nx">j</span><span class="p">.</span><span class="nx">getElementsByTagName</span><span class="p">(</span><span class="s2">&quot;head&quot;</span><span class="p">)[</span><span class="mi">0</span><span class="p">];</span><span class="k">if</span><span class="p">(</span><span class="o">!</span><span class="nx">aa</span><span class="p">){</span><span class="k">return</span><span class="p">}</span><span class="kd">var</span> <span class="nx">X</span><span class="o">=</span><span class="p">(</span><span class="nx">ad</span><span class="o">&amp;&amp;</span><span class="k">typeof</span> <span class="nx">ad</span><span class="o">==</span><span class="s2">&quot;string&quot;</span><span class="p">)</span><span class="o">?</span><span class="nx">ad</span><span class="o">:</span><span class="s2">&quot;screen&quot;</span><span class="p">;</span><span class="k">if</span><span class="p">(</span><span class="nx">ab</span><span class="p">){</span><span class="nx">n</span><span class="o">=</span><span class="kc">null</span><span class="p">;</span><span class="nx">G</span><span class="o">=</span><span class="kc">null</span><span class="p">}</span><span class="k">if</span><span class="p">(</span><span class="o">!</span><span class="nx">n</span><span class="o">||</span><span class="nx">G</span><span class="o">!=</span><span class="nx">X</span><span class="p">){</span><span class="kd">var</span> <span class="nx">Z</span><span class="o">=</span><span class="nx">C</span><span class="p">(</span><span class="s2">&quot;style&quot;</span><span class="p">);</span><span class="nx">Z</span><span class="p">.</span><span class="nx">setAttribute</span><span class="p">(</span><span class="s2">&quot;type&quot;</span><span class="p">,</span><span class="s2">&quot;text/css&quot;</span><span class="p">);</span><span class="nx">Z</span><span class="p">.</span><span class="nx">setAttribute</span><span class="p">(</span><span class="s2">&quot;media&quot;</span><span class="p">,</span><span class="nx">X</span><span class="p">);</span><span class="nx">n</span><span class="o">=</span><span class="nx">aa</span><span class="p">.</span><span class="nx">appendChild</span><span class="p">(</span><span class="nx">Z</span><span class="p">);</span><span class="k">if</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">ie</span><span class="o">&amp;&amp;</span><span class="nx">M</span><span class="p">.</span><span class="nx">win</span><span class="o">&amp;&amp;</span><span class="k">typeof</span> <span class="nx">j</span><span class="p">.</span><span class="nx">styleSheets</span><span class="o">!=</span><span class="nx">D</span><span class="o">&amp;&amp;</span><span class="nx">j</span><span class="p">.</span><span class="nx">styleSheets</span><span class="p">.</span><span class="nx">length</span><span class="o">&gt;</span><span class="mi">0</span><span class="p">){</span><span class="nx">n</span><span class="o">=</span><span class="nx">j</span><span class="p">.</span><span class="nx">styleSheets</span><span class="p">[</span><span class="nx">j</span><span class="p">.</span><span class="nx">styleSheets</span><span class="p">.</span><span class="nx">length</span><span class="o">-</span><span class="mi">1</span><span class="p">]}</span><span class="nx">G</span><span class="o">=</span><span class="nx">X</span><span class="p">}</span><span class="k">if</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">ie</span><span class="o">&amp;&amp;</span><span class="nx">M</span><span class="p">.</span><span class="nx">win</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="nx">n</span><span class="o">&amp;&amp;</span><span class="k">typeof</span> <span class="nx">n</span><span class="p">.</span><span class="nx">addRule</span><span class="o">==</span><span class="nx">r</span><span class="p">){</span><span class="nx">n</span><span class="p">.</span><span class="nx">addRule</span><span class="p">(</span><span class="nx">ac</span><span class="p">,</span><span class="nx">Y</span><span class="p">)}}</span><span class="k">else</span><span class="p">{</span><span class="k">if</span><span class="p">(</span><span class="nx">n</span><span class="o">&amp;&amp;</span><span class="k">typeof</span> <span class="nx">j</span><span class="p">.</span><span class="nx">createTextNode</span><span class="o">!=</span><span class="nx">D</span><span class="p">){</span><span class="nx">n</span><span class="p">.</span><span class="nx">appendChild</span><span class="p">(</span><span class="nx">j</span><span class="p">.</span><span class="nx">createTextNode</span><span class="p">(</span><span class="nx">ac</span><span class="o">+</span><span class="s2">&quot; {&quot;</span><span class="o">+</span><span class="nx">Y</span><span class="o">+</span><span class="s2">&quot;}&quot;</span><span class="p">))}}}</span><span class="kd">function</span> <span class="nx">w</span><span class="p">(</span><span class="nx">Z</span><span class="p">,</span><span class="nx">X</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="o">!</span><span class="nx">m</span><span class="p">){</span><span class="k">return</span><span class="p">}</span><span class="kd">var</span> <span class="nx">Y</span><span class="o">=</span><span class="nx">X</span><span class="o">?</span><span class="s2">&quot;visible&quot;</span><span class="o">:</span><span class="s2">&quot;hidden&quot;</span><span class="p">;</span><span class="k">if</span><span class="p">(</span><span class="nx">J</span><span class="o">&amp;&amp;</span><span class="nx">c</span><span class="p">(</span><span class="nx">Z</span><span class="p">)){</span><span class="nx">c</span><span class="p">(</span><span class="nx">Z</span><span class="p">).</span><span class="nx">style</span><span class="p">.</span><span class="nx">visibility</span><span class="o">=</span><span class="nx">Y</span><span class="p">}</span><span class="k">else</span><span class="p">{</span><span class="nx">v</span><span class="p">(</span><span class="s2">&quot;#&quot;</span><span class="o">+</span><span class="nx">Z</span><span class="p">,</span><span class="s2">&quot;visibility:&quot;</span><span class="o">+</span><span class="nx">Y</span><span class="p">)}}</span><span class="kd">function</span> <span class="nx">L</span><span class="p">(</span><span class="nx">Y</span><span class="p">){</span><span class="kd">var</span> <span class="nx">Z</span><span class="o">=</span><span class="sr">/[\\\&quot;&lt;&gt;\.;]/</span><span class="p">;</span><span class="kd">var</span> <span class="nx">X</span><span class="o">=</span><span class="nx">Z</span><span class="p">.</span><span class="nx">exec</span><span class="p">(</span><span class="nx">Y</span><span class="p">)</span><span class="o">!=</span><span class="kc">null</span><span class="p">;</span><span class="k">return</span> <span class="nx">X</span><span class="o">&amp;&amp;</span><span class="k">typeof</span> <span class="nb">encodeURIComponent</span><span class="o">!=</span><span class="nx">D</span><span class="o">?</span><span class="nb">encodeURIComponent</span><span class="p">(</span><span class="nx">Y</span><span class="p">)</span><span class="o">:</span><span class="nx">Y</span><span class="p">}</span><span class="kd">var</span> <span class="nx">d</span><span class="o">=</span><span class="kd">function</span><span class="p">(){</span><span class="k">if</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">ie</span><span class="o">&amp;&amp;</span><span class="nx">M</span><span class="p">.</span><span class="nx">win</span><span class="p">){</span><span class="nb">window</span><span class="p">.</span><span class="nx">attachEvent</span><span class="p">(</span><span class="s2">&quot;onunload&quot;</span><span class="p">,</span><span class="kd">function</span><span class="p">(){</span><span class="kd">var</span> <span class="nx">ac</span><span class="o">=</span><span class="nx">I</span><span class="p">.</span><span class="nx">length</span><span class="p">;</span><span class="k">for</span><span class="p">(</span><span class="kd">var</span> <span class="nx">ab</span><span class="o">=</span><span class="mi">0</span><span class="p">;</span><span class="nx">ab</span><span class="o">&lt;</span><span class="nx">ac</span><span class="p">;</span><span class="nx">ab</span><span class="o">++</span><span class="p">){</span><span class="nx">I</span><span class="p">[</span><span class="nx">ab</span><span class="p">][</span><span class="mi">0</span><span class="p">].</span><span class="nx">detachEvent</span><span class="p">(</span><span class="nx">I</span><span class="p">[</span><span class="nx">ab</span><span class="p">][</span><span class="mi">1</span><span class="p">],</span><span class="nx">I</span><span class="p">[</span><span class="nx">ab</span><span class="p">][</span><span class="mi">2</span><span class="p">])}</span><span class="kd">var</span> <span class="nx">Z</span><span class="o">=</span><span class="nx">N</span><span class="p">.</span><span class="nx">length</span><span class="p">;</span><span class="k">for</span><span class="p">(</span><span class="kd">var</span> <span class="nx">aa</span><span class="o">=</span><span class="mi">0</span><span class="p">;</span><span class="nx">aa</span><span class="o">&lt;</span><span class="nx">Z</span><span class="p">;</span><span class="nx">aa</span><span class="o">++</span><span class="p">){</span><span class="nx">y</span><span class="p">(</span><span class="nx">N</span><span class="p">[</span><span class="nx">aa</span><span class="p">])}</span><span class="k">for</span><span class="p">(</span><span class="kd">var</span> <span class="nx">Y</span> <span class="k">in</span> <span class="nx">M</span><span class="p">){</span><span class="nx">M</span><span class="p">[</span><span class="nx">Y</span><span class="p">]</span><span class="o">=</span><span class="kc">null</span><span class="p">}</span><span class="nx">M</span><span class="o">=</span><span class="kc">null</span><span class="p">;</span><span class="k">for</span><span class="p">(</span><span class="kd">var</span> <span class="nx">X</span> <span class="k">in</span> <span class="nx">swfobject</span><span class="p">){</span><span class="nx">swfobject</span><span class="p">[</span><span class="nx">X</span><span class="p">]</span><span class="o">=</span><span class="kc">null</span><span class="p">}</span><span class="nx">swfobject</span><span class="o">=</span><span class="kc">null</span><span class="p">})}}();</span><span class="k">return</span><span class="p">{</span><span class="nx">registerObject</span><span class="o">:</span><span class="kd">function</span><span class="p">(</span><span class="nx">ab</span><span class="p">,</span><span class="nx">X</span><span class="p">,</span><span class="nx">aa</span><span class="p">,</span><span class="nx">Z</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">w3</span><span class="o">&amp;&amp;</span><span class="nx">ab</span><span class="o">&amp;&amp;</span><span class="nx">X</span><span class="p">){</span><span class="kd">var</span> <span class="nx">Y</span><span class="o">=</span><span class="p">{};</span><span class="nx">Y</span><span class="p">.</span><span class="nx">id</span><span class="o">=</span><span class="nx">ab</span><span class="p">;</span><span class="nx">Y</span><span class="p">.</span><span class="nx">swfVersion</span><span class="o">=</span><span class="nx">X</span><span class="p">;</span><span class="nx">Y</span><span class="p">.</span><span class="nx">expressInstall</span><span class="o">=</span><span class="nx">aa</span><span class="p">;</span><span class="nx">Y</span><span class="p">.</span><span class="nx">callbackFn</span><span class="o">=</span><span class="nx">Z</span><span class="p">;</span><span class="nx">o</span><span class="p">[</span><span class="nx">o</span><span class="p">.</span><span class="nx">length</span><span class="p">]</span><span class="o">=</span><span class="nx">Y</span><span class="p">;</span><span class="nx">w</span><span class="p">(</span><span class="nx">ab</span><span class="p">,</span><span class="kc">false</span><span class="p">)}</span><span class="k">else</span><span class="p">{</span><span class="k">if</span><span class="p">(</span><span class="nx">Z</span><span class="p">){</span><span class="nx">Z</span><span class="p">({</span><span class="nx">success</span><span class="o">:</span><span class="kc">false</span><span class="p">,</span><span class="nx">id</span><span class="o">:</span><span class="nx">ab</span><span class="p">})}}},</span><span class="nx">getObjectById</span><span class="o">:</span><span class="kd">function</span><span class="p">(</span><span class="nx">X</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">w3</span><span class="p">){</span><span class="k">return</span> <span class="nx">z</span><span class="p">(</span><span class="nx">X</span><span class="p">)}},</span><span class="nx">embedSWF</span><span class="o">:</span><span class="kd">function</span><span class="p">(</span><span class="nx">ab</span><span class="p">,</span><span class="nx">ah</span><span class="p">,</span><span class="nx">ae</span><span class="p">,</span><span class="nx">ag</span><span class="p">,</span><span class="nx">Y</span><span class="p">,</span><span class="nx">aa</span><span class="p">,</span><span class="nx">Z</span><span class="p">,</span><span class="nx">ad</span><span class="p">,</span><span class="nx">af</span><span class="p">,</span><span class="nx">ac</span><span class="p">){</span><span class="kd">var</span> <span class="nx">X</span><span class="o">=</span><span class="p">{</span><span class="nx">success</span><span class="o">:</span><span class="kc">false</span><span class="p">,</span><span class="nx">id</span><span class="o">:</span><span class="nx">ah</span><span class="p">};</span><span class="k">if</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">w3</span><span class="o">&amp;&amp;!</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">wk</span><span class="o">&amp;&amp;</span><span class="nx">M</span><span class="p">.</span><span class="nx">wk</span><span class="o">&lt;</span><span class="mi">312</span><span class="p">)</span><span class="o">&amp;&amp;</span><span class="nx">ab</span><span class="o">&amp;&amp;</span><span class="nx">ah</span><span class="o">&amp;&amp;</span><span class="nx">ae</span><span class="o">&amp;&amp;</span><span class="nx">ag</span><span class="o">&amp;&amp;</span><span class="nx">Y</span><span class="p">){</span><span class="nx">w</span><span class="p">(</span><span class="nx">ah</span><span class="p">,</span><span class="kc">false</span><span class="p">);</span><span class="nx">K</span><span class="p">(</span><span class="kd">function</span><span class="p">(){</span><span class="nx">ae</span><span class="o">+=</span><span class="s2">&quot;&quot;</span><span class="p">;</span><span class="nx">ag</span><span class="o">+=</span><span class="s2">&quot;&quot;</span><span class="p">;</span><span class="kd">var</span> <span class="nx">aj</span><span class="o">=</span><span class="p">{};</span><span class="k">if</span><span class="p">(</span><span class="nx">af</span><span class="o">&amp;&amp;</span><span class="k">typeof</span> <span class="nx">af</span><span class="o">===</span><span class="nx">r</span><span class="p">){</span><span class="k">for</span><span class="p">(</span><span class="kd">var</span> <span class="nx">al</span> <span class="k">in</span> <span class="nx">af</span><span class="p">){</span><span class="nx">aj</span><span class="p">[</span><span class="nx">al</span><span class="p">]</span><span class="o">=</span><span class="nx">af</span><span class="p">[</span><span class="nx">al</span><span class="p">]}}</span><span class="nx">aj</span><span class="p">.</span><span class="nx">data</span><span class="o">=</span><span class="nx">ab</span><span class="p">;</span><span class="nx">aj</span><span class="p">.</span><span class="nx">width</span><span class="o">=</span><span class="nx">ae</span><span class="p">;</span><span class="nx">aj</span><span class="p">.</span><span class="nx">height</span><span class="o">=</span><span class="nx">ag</span><span class="p">;</span><span class="kd">var</span> <span class="nx">am</span><span class="o">=</span><span class="p">{};</span><span class="k">if</span><span class="p">(</span><span class="nx">ad</span><span class="o">&amp;&amp;</span><span class="k">typeof</span> <span class="nx">ad</span><span class="o">===</span><span class="nx">r</span><span class="p">){</span><span class="k">for</span><span class="p">(</span><span class="kd">var</span> <span class="nx">ak</span> <span class="k">in</span> <span class="nx">ad</span><span class="p">){</span><span class="nx">am</span><span class="p">[</span><span class="nx">ak</span><span class="p">]</span><span class="o">=</span><span class="nx">ad</span><span class="p">[</span><span class="nx">ak</span><span class="p">]}}</span><span class="k">if</span><span class="p">(</span><span class="nx">Z</span><span class="o">&amp;&amp;</span><span class="k">typeof</span> <span class="nx">Z</span><span class="o">===</span><span class="nx">r</span><span class="p">){</span><span class="k">for</span><span class="p">(</span><span class="kd">var</span> <span class="nx">ai</span> <span class="k">in</span> <span class="nx">Z</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="k">typeof</span> <span class="nx">am</span><span class="p">.</span><span class="nx">flashvars</span><span class="o">!=</span><span class="nx">D</span><span class="p">){</span><span class="nx">am</span><span class="p">.</span><span class="nx">flashvars</span><span class="o">+=</span><span class="s2">&quot;&amp;&quot;</span><span class="o">+</span><span class="nx">ai</span><span class="o">+</span><span class="s2">&quot;=&quot;</span><span class="o">+</span><span class="nx">Z</span><span class="p">[</span><span class="nx">ai</span><span class="p">]}</span><span class="k">else</span><span class="p">{</span><span class="nx">am</span><span class="p">.</span><span class="nx">flashvars</span><span class="o">=</span><span class="nx">ai</span><span class="o">+</span><span class="s2">&quot;=&quot;</span><span class="o">+</span><span class="nx">Z</span><span class="p">[</span><span class="nx">ai</span><span class="p">]}}}</span><span class="k">if</span><span class="p">(</span><span class="nx">F</span><span class="p">(</span><span class="nx">Y</span><span class="p">)){</span><span class="kd">var</span> <span class="nx">an</span><span class="o">=</span><span class="nx">u</span><span class="p">(</span><span class="nx">aj</span><span class="p">,</span><span class="nx">am</span><span class="p">,</span><span class="nx">ah</span><span class="p">);</span><span class="k">if</span><span class="p">(</span><span class="nx">aj</span><span class="p">.</span><span class="nx">id</span><span class="o">==</span><span class="nx">ah</span><span class="p">){</span><span class="nx">w</span><span class="p">(</span><span class="nx">ah</span><span class="p">,</span><span class="kc">true</span><span class="p">)}</span><span class="nx">X</span><span class="p">.</span><span class="nx">success</span><span class="o">=</span><span class="kc">true</span><span class="p">;</span><span class="nx">X</span><span class="p">.</span><span class="nx">ref</span><span class="o">=</span><span class="nx">an</span><span class="p">}</span><span class="k">else</span><span class="p">{</span><span class="k">if</span><span class="p">(</span><span class="nx">aa</span><span class="o">&amp;&amp;</span><span class="nx">A</span><span class="p">()){</span><span class="nx">aj</span><span class="p">.</span><span class="nx">data</span><span class="o">=</span><span class="nx">aa</span><span class="p">;</span><span class="nx">P</span><span class="p">(</span><span class="nx">aj</span><span class="p">,</span><span class="nx">am</span><span class="p">,</span><span class="nx">ah</span><span class="p">,</span><span class="nx">ac</span><span class="p">);</span><span class="k">return</span><span class="p">}</span><span class="k">else</span><span class="p">{</span><span class="nx">w</span><span class="p">(</span><span class="nx">ah</span><span class="p">,</span><span class="kc">true</span><span class="p">)}}</span><span class="k">if</span><span class="p">(</span><span class="nx">ac</span><span class="p">){</span><span class="nx">ac</span><span class="p">(</span><span class="nx">X</span><span class="p">)}})}</span><span class="k">else</span><span class="p">{</span><span class="k">if</span><span class="p">(</span><span class="nx">ac</span><span class="p">){</span><span class="nx">ac</span><span class="p">(</span><span class="nx">X</span><span class="p">)}}},</span><span class="nx">switchOffAutoHideShow</span><span class="o">:</span><span class="kd">function</span><span class="p">(){</span><span class="nx">m</span><span class="o">=</span><span class="kc">false</span><span class="p">},</span><span class="nx">ua</span><span class="o">:</span><span class="nx">M</span><span class="p">,</span><span class="nx">getFlashPlayerVersion</span><span class="o">:</span><span class="kd">function</span><span class="p">(){</span><span class="k">return</span><span class="p">{</span><span class="nx">major</span><span class="o">:</span><span class="nx">M</span><span class="p">.</span><span class="nx">pv</span><span class="p">[</span><span class="mi">0</span><span class="p">],</span><span class="nx">minor</span><span class="o">:</span><span class="nx">M</span><span class="p">.</span><span class="nx">pv</span><span class="p">[</span><span class="mi">1</span><span class="p">],</span><span class="nx">release</span><span class="o">:</span><span class="nx">M</span><span class="p">.</span><span class="nx">pv</span><span class="p">[</span><span class="mi">2</span><span class="p">]}},</span><span class="nx">hasFlashPlayerVersion</span><span class="o">:</span><span class="nx">F</span><span class="p">,</span><span class="nx">createSWF</span><span class="o">:</span><span class="kd">function</span><span class="p">(</span><span class="nx">Z</span><span class="p">,</span><span class="nx">Y</span><span class="p">,</span><span class="nx">X</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">w3</span><span class="p">){</span><span class="k">return</span> <span class="nx">u</span><span class="p">(</span><span class="nx">Z</span><span class="p">,</span><span class="nx">Y</span><span class="p">,</span><span class="nx">X</span><span class="p">)}</span><span class="k">else</span><span class="p">{</span><span class="k">return</span> <span class="kc">undefined</span><span class="p">}},</span><span class="nx">showExpressInstall</span><span class="o">:</span><span class="kd">function</span><span class="p">(</span><span class="nx">Z</span><span class="p">,</span><span class="nx">aa</span><span class="p">,</span><span class="nx">X</span><span class="p">,</span><span class="nx">Y</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">w3</span><span class="o">&amp;&amp;</span><span class="nx">A</span><span class="p">()){</span><span class="nx">P</span><span class="p">(</span><span class="nx">Z</span><span class="p">,</span><span class="nx">aa</span><span class="p">,</span><span class="nx">X</span><span class="p">,</span><span class="nx">Y</span><span class="p">)}},</span><span class="nx">removeSWF</span><span class="o">:</span><span class="kd">function</span><span class="p">(</span><span class="nx">X</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">w3</span><span class="p">){</span><span class="nx">y</span><span class="p">(</span><span class="nx">X</span><span class="p">)}},</span><span class="nx">createCSS</span><span class="o">:</span><span class="kd">function</span><span class="p">(</span><span class="nx">aa</span><span class="p">,</span><span class="nx">Z</span><span class="p">,</span><span class="nx">Y</span><span class="p">,</span><span class="nx">X</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">w3</span><span class="p">){</span><span class="nx">v</span><span class="p">(</span><span class="nx">aa</span><span class="p">,</span><span class="nx">Z</span><span class="p">,</span><span class="nx">Y</span><span class="p">,</span><span class="nx">X</span><span class="p">)}},</span><span class="nx">addDomLoadEvent</span><span class="o">:</span><span class="nx">K</span><span class="p">,</span><span class="nx">addLoadEvent</span><span class="o">:</span><span class="nx">s</span><span class="p">,</span><span class="nx">getQueryParamValue</span><span class="o">:</span><span class="kd">function</span><span class="p">(</span><span class="nx">aa</span><span class="p">){</span><span class="kd">var</span> <span class="nx">Z</span><span class="o">=</span><span class="nx">j</span><span class="p">.</span><span class="nx">location</span><span class="p">.</span><span class="nx">search</span><span class="o">||</span><span class="nx">j</span><span class="p">.</span><span class="nx">location</span><span class="p">.</span><span class="nx">hash</span><span class="p">;</span><span class="k">if</span><span class="p">(</span><span class="nx">Z</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="sr">/\?/</span><span class="p">.</span><span class="nx">test</span><span class="p">(</span><span class="nx">Z</span><span class="p">)){</span><span class="nx">Z</span><span class="o">=</span><span class="nx">Z</span><span class="p">.</span><span class="nx">split</span><span class="p">(</span><span class="s2">&quot;?&quot;</span><span class="p">)[</span><span class="mi">1</span><span class="p">]}</span><span class="k">if</span><span class="p">(</span><span class="nx">aa</span><span class="o">==</span><span class="kc">null</span><span class="p">){</span><span class="k">return</span> <span class="nx">L</span><span class="p">(</span><span class="nx">Z</span><span class="p">)}</span><span class="kd">var</span> <span class="nx">Y</span><span class="o">=</span><span class="nx">Z</span><span class="p">.</span><span class="nx">split</span><span class="p">(</span><span class="s2">&quot;&amp;&quot;</span><span class="p">);</span><span class="k">for</span><span class="p">(</span><span class="kd">var</span> <span class="nx">X</span><span class="o">=</span><span class="mi">0</span><span class="p">;</span><span class="nx">X</span><span class="o">&lt;</span><span class="nx">Y</span><span class="p">.</span><span class="nx">length</span><span class="p">;</span><span class="nx">X</span><span class="o">++</span><span class="p">){</span><span class="k">if</span><span class="p">(</span><span class="nx">Y</span><span class="p">[</span><span class="nx">X</span><span class="p">].</span><span class="nx">substring</span><span class="p">(</span><span class="mi">0</span><span class="p">,</span><span class="nx">Y</span><span class="p">[</span><span class="nx">X</span><span class="p">].</span><span class="nx">indexOf</span><span class="p">(</span><span class="s2">&quot;=&quot;</span><span class="p">))</span><span class="o">==</span><span class="nx">aa</span><span class="p">){</span><span class="k">return</span> <span class="nx">L</span><span class="p">(</span><span class="nx">Y</span><span class="p">[</span><span class="nx">X</span><span class="p">].</span><span class="nx">substring</span><span class="p">((</span><span class="nx">Y</span><span class="p">[</span><span class="nx">X</span><span class="p">].</span><span class="nx">indexOf</span><span class="p">(</span><span class="s2">&quot;=&quot;</span><span class="p">)</span><span class="o">+</span><span class="mi">1</span><span class="p">)))}}}</span><span class="k">return</span><span class="s2">&quot;&quot;</span><span class="p">},</span><span class="nx">expressInstallCallback</span><span class="o">:</span><span class="kd">function</span><span class="p">(){</span><span class="k">if</span><span class="p">(</span><span class="nx">a</span><span class="p">){</span><span class="kd">var</span> <span class="nx">X</span><span class="o">=</span><span class="nx">c</span><span class="p">(</span><span class="nx">R</span><span class="p">);</span><span class="k">if</span><span class="p">(</span><span class="nx">X</span><span class="o">&amp;&amp;</span><span class="nx">l</span><span class="p">){</span><span class="nx">X</span><span class="p">.</span><span class="nx">parentNode</span><span class="p">.</span><span class="nx">replaceChild</span><span class="p">(</span><span class="nx">l</span><span class="p">,</span><span class="nx">X</span><span class="p">);</span><span class="k">if</span><span class="p">(</span><span class="nx">Q</span><span class="p">){</span><span class="nx">w</span><span class="p">(</span><span class="nx">Q</span><span class="p">,</span><span class="kc">true</span><span class="p">);</span><span class="k">if</span><span class="p">(</span><span class="nx">M</span><span class="p">.</span><span class="nx">ie</span><span class="o">&amp;&amp;</span><span class="nx">M</span><span class="p">.</span><span class="nx">win</span><span class="p">){</span><span class="nx">l</span><span class="p">.</span><span class="nx">style</span><span class="p">.</span><span class="nx">display</span><span class="o">=</span><span class="s2">&quot;block&quot;</span><span class="p">}}</span><span class="k">if</span><span class="p">(</span><span class="nx">E</span><span class="p">){</span><span class="nx">E</span><span class="p">(</span><span class="nx">B</span><span class="p">)}}</span><span class="nx">a</span><span class="o">=</span><span class="kc">false</span><span class="p">}}}}();</span></div></pre></div>
              
            
          </td>
        </tr>
      </table>
    
  </div>


          </div>
        </div>
      </div>
    </div>
  

  </div>


<div class="frame frame-loading" style="display:none;">
  <img src="/images/modules/ajax/big_spinner_336699.gif">
</div>

    </div>
  
      
    </div>

    <div id="footer" class="clearfix">
      <div class="site">
        <div class="sponsor">
          <a href="http://www.rackspace.com" class="logo">
            <img alt="Dedicated Server" src="https://assets1.github.com/images/modules/footer/rackspace_logo.png?v2?fcea8a71e43a6abea9b38ae62a9eeb7e84f5652a" />
          </a>
          Powered by the <a href="http://www.rackspace.com ">Dedicated
          Servers</a> and<br/> <a href="http://www.rackspacecloud.com">Cloud
          Computing</a> of Rackspace Hosting<span>&reg;</span>
        </div>

        <ul class="links">
          <li class="blog"><a href="https://github.com/blog">Blog</a></li>
          <li><a href="http://support.github.com">Support</a></li>
          <li><a href="https://github.com/training">Training</a></li>
          <li><a href="http://jobs.github.com">Job Board</a></li>
          <li><a href="http://shop.github.com">Shop</a></li>
          <li><a href="https://github.com/contact">Contact</a></li>
          <li><a href="http://develop.github.com">API</a></li>
          <li><a href="http://status.github.com">Status</a></li>
        </ul>
        <ul class="sosueme">
          <li class="main">&copy; 2011 <span id="_rrt" title="0.10071s from fe4.rs.github.com">GitHub</span> Inc. All rights reserved.</li>
          <li><a href="/site/terms">Terms of Service</a></li>
          <li><a href="/site/privacy">Privacy</a></li>
          <li><a href="https://github.com/security">Security</a></li>
        </ul>
      </div>
    </div><!-- /#footer -->

    
      
      
        <!-- current locale:  -->
        <div class="locales">
          <div class="site">

            <ul class="choices clearfix limited-locales">
              <li><span class="current">English</span></li>
              
                  <li><a rel="nofollow" href="?locale=de">Deutsch</a></li>
              
                  <li><a rel="nofollow" href="?locale=fr">Français</a></li>
              
                  <li><a rel="nofollow" href="?locale=ja">日本語</a></li>
              
                  <li><a rel="nofollow" href="?locale=pt-BR">Português (BR)</a></li>
              
                  <li><a rel="nofollow" href="?locale=ru">Русский</a></li>
              
                  <li><a rel="nofollow" href="?locale=zh">中文</a></li>
              
              <li class="all"><a href="#" class="minibutton btn-forward js-all-locales"><span><span class="icon"></span>See all available languages</span></a></li>
            </ul>

            <div class="all-locales clearfix">
              <h3>Your current locale selection: <strong>English</strong>. Choose another?</h3>
              
              
                <ul class="choices">
                  
                      <li><a rel="nofollow" href="?locale=en">English</a></li>
                  
                      <li><a rel="nofollow" href="?locale=af">Afrikaans</a></li>
                  
                      <li><a rel="nofollow" href="?locale=ca">Català</a></li>
                  
                      <li><a rel="nofollow" href="?locale=cs">Čeština</a></li>
                  
                </ul>
              
                <ul class="choices">
                  
                      <li><a rel="nofollow" href="?locale=de">Deutsch</a></li>
                  
                      <li><a rel="nofollow" href="?locale=es">Español</a></li>
                  
                      <li><a rel="nofollow" href="?locale=fr">Français</a></li>
                  
                      <li><a rel="nofollow" href="?locale=hr">Hrvatski</a></li>
                  
                </ul>
              
                <ul class="choices">
                  
                      <li><a rel="nofollow" href="?locale=id">Indonesia</a></li>
                  
                      <li><a rel="nofollow" href="?locale=it">Italiano</a></li>
                  
                      <li><a rel="nofollow" href="?locale=ja">日本語</a></li>
                  
                      <li><a rel="nofollow" href="?locale=nl">Nederlands</a></li>
                  
                </ul>
              
                <ul class="choices">
                  
                      <li><a rel="nofollow" href="?locale=no">Norsk</a></li>
                  
                      <li><a rel="nofollow" href="?locale=pl">Polski</a></li>
                  
                      <li><a rel="nofollow" href="?locale=pt-BR">Português (BR)</a></li>
                  
                      <li><a rel="nofollow" href="?locale=ru">Русский</a></li>
                  
                </ul>
              
                <ul class="choices">
                  
                      <li><a rel="nofollow" href="?locale=sr">Српски</a></li>
                  
                      <li><a rel="nofollow" href="?locale=sv">Svenska</a></li>
                  
                      <li><a rel="nofollow" href="?locale=zh">中文</a></li>
                  
                </ul>
              
            </div>

          </div>
          <div class="fade"></div>
        </div>
      
    

    <script>window._auth_token = "ba41504442878ffdb5ad00e716b7d565fbb4dca8"</script>
    <div id="keyboard_shortcuts_pane" style="display:none">
  <h2>Keyboard Shortcuts</h2>

  <div class="columns threecols">
    <div class="column first">
      <h3>Site wide shortcuts</h3>
      <dl class="keyboard-mappings">
        <dt>s</dt>
        <dd>Focus site search</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>?</dt>
        <dd>Bring up this help dialog</dd>
      </dl>
    </div><!-- /.column.first -->
    <div class="column middle">
      <h3>Commit list</h3>
      <dl class="keyboard-mappings">
        <dt>j</dt>
        <dd>Move selected down</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>k</dt>
        <dd>Move selected up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>t</dt>
        <dd>Open tree</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>p</dt>
        <dd>Open parent</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>c <em>or</em> o <em>or</em> enter</dt>
        <dd>Open commit</dd>
      </dl>
    </div><!-- /.column.first -->
    <div class="column last">
      <h3>Pull request list</h3>
      <dl class="keyboard-mappings">
        <dt>j</dt>
        <dd>Move selected down</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>k</dt>
        <dd>Move selected up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>o <em>or</em> enter</dt>
        <dd>Open issue</dd>
      </dl>
    </div><!-- /.columns.last -->
  </div><!-- /.columns.equacols -->

  <div class="rule"></div>

  <h3>Issues</h3>

  <div class="columns threecols">
    <div class="column first">
      <dl class="keyboard-mappings">
        <dt>j</dt>
        <dd>Move selected down</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>k</dt>
        <dd>Move selected up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>x</dt>
        <dd>Toggle select target</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>o <em>or</em> enter</dt>
        <dd>Open issue</dd>
      </dl>
    </div><!-- /.column.first -->
    <div class="column middle">
      <dl class="keyboard-mappings">
        <dt>I</dt>
        <dd>Mark selected as read</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>U</dt>
        <dd>Mark selected as unread</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>e</dt>
        <dd>Close selected</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>y</dt>
        <dd>Remove selected from view</dd>
      </dl>
    </div><!-- /.column.middle -->
    <div class="column last">
      <dl class="keyboard-mappings">
        <dt>c</dt>
        <dd>Create issue</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>l</dt>
        <dd>Create label</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>i</dt>
        <dd>Back to inbox</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>u</dt>
        <dd>Back to issues</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>/</dt>
        <dd>Focus issues search</dd>
      </dl>
    </div>
  </div>

  <div class="rule"></div>

  <h3>Network Graph</h3>
  <div class="columns equacols">
    <div class="column first">
      <dl class="keyboard-mappings">
        <dt>← <em>or</em> h</dt>
        <dd>Scroll left</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>→ <em>or</em> l</dt>
        <dd>Scroll right</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>↑ <em>or</em> k</dt>
        <dd>Scroll up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>↓ <em>or</em> j</dt>
        <dd>Scroll down</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>t</dt>
        <dd>Toggle visibility of head labels</dd>
      </dl>
    </div><!-- /.column.first -->
    <div class="column last">
      <dl class="keyboard-mappings">
        <dt>shift ← <em>or</em> shift h</dt>
        <dd>Scroll all the way left</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>shift → <em>or</em> shift l</dt>
        <dd>Scroll all the way right</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>shift ↑ <em>or</em> shift k</dt>
        <dd>Scroll all the way up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>shift ↓ <em>or</em> shift j</dt>
        <dd>Scroll all the way down</dd>
      </dl>
    </div><!-- /.column.last -->
  </div>

</div>
    

    <!--[if IE 8]>
    <script type="text/javascript" charset="utf-8">
      $(document.body).addClass("ie8")
    </script>
    <![endif]-->

    <!--[if IE 7]>
    <script type="text/javascript" charset="utf-8">
      $(document.body).addClass("ie7")
    </script>
    <![endif]-->

    
    <script type='text/javascript'></script>
    
  </body>
</html>

