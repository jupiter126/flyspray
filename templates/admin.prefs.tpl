<div id="toolbox">
  <h3>{L('admintoolboxlong')} :: {L('preferences')}</h3>

  <form action="{$baseurl}" method="post">
  <ul id="submenu">
   <li><a href="#general">{L('general')}</a></li>
   <li><a href="#userregistration">{L('userregistration')}</a></li>
   <li><a href="#notifications">{L('notifications')}</a></li>
   <li><a href="#lookandfeel">{L('lookandfeel')}</a></li>
  </ul>
  
   <div id="general" class="tab">
      <table class="admin">
        <tr>
          <td><label for="defaultproject">{L('defaultproject')}</label></td>
          <td>
            <select id="defaultproject" name="default_project">
              {!tpl_options(array_merge(array(0 => L('allprojects')), $fs->listProjects()), $fs->prefs['default_project'])}
            </select>
          </td>
        </tr>
        <tr>
          <td><label for="langcode">{L('language')}</label></td>
          <td>
            <select id="langcode" name="lang_code">
              {!tpl_options($fs->listLangs(), $fs->prefs['lang_code'], true)}
            </select>
          </td>
        </tr>
        <tr>
          <td><label for="dateformat">{L('dateformat')}</label></td>
          <td>
            <input id="dateformat" name="dateformat" type="text" class="text" size="40" maxlength="30" value="{$fs->prefs['dateformat']}" />
          </td>
        </tr>
        <tr>
          <td><label for="dateformat_extended">{L('dateformat_extended')}</label></td>
          <td>
            <input id="dateformat_extended" name="dateformat_extended" class="text" type="text" size="40" maxlength="30" value="{$fs->prefs['dateformat_extended']}" />
          </td>
        </tr>
        <tr>
          <td><label for="cache_feeds">{L('cache_feeds')}</label></td>
          <td>
            <select id="cache_feeds" name="cache_feeds">
            {!tpl_options(array('0' => L('no_cache'), '1' => L('cache_disk'), '2' => L('cache_db')), $fs->prefs['cache_feeds'])}
            </select>
          </td>
        </tr>
      </table>
    </div>

    <div id="userregistration" class="tab">
      <table class="admin">
        <tr>
          <td><label for="allowusersignups">{L('anonreg')}</label></td>
          <td>{!tpl_checkbox('anon_reg', $fs->prefs['anon_reg'], 'allowusersignups')}</td>
        </tr>
        <tr>
          <td><label for="spamproof">{L('spamproof')}</label></td>
          <td>{!tpl_checkbox('spam_proof', $fs->prefs['spam_proof'], 'spamproof')}</td>
        </tr>
        <tr>
          <td><label for="defaultglobalgroup">{L('defaultglobalgroup')}</label></td>
          <td>
            <select id="defaultglobalgroup" name="anon_group">
              {!tpl_options($fs->listGroups(), $fs->prefs['anon_group'])}
            </select>
          </td>
        </tr>
        <tr>
          <td><label id="groupsassignedlabel">{L('groupassigned')}</label></td>
          <td class="text">
            <?php foreach($fs->listGroups() as $group): ?>
            {!tpl_checkbox('assigned_groups['.$group['group_id'].']',
            strstr($fs->prefs['assigned_groups'], $group['group_id']) !== false)}
            {$group['group_name']}<br />
            <?php endforeach; ?>
          </td>
        </tr>
      </table>
    </div>

    <div id="notifications" class="tab">
      <table class="admin">
        <tr>
          <td><label for="usernotify">{L('forcenotify')}</label></td>
          <td>
            <select id="usernotify" name="user_notify">
              {!tpl_options(array(L('neversend'), L('userchoose'), L('email'), L('jabber')), $fs->prefs['user_notify'])}
            </select>
          </td>
        </tr>
        <tr>
          <th colspan="2"><hr />
            {L('emailnotify')}
          </th>
        </tr>
        <tr>
          <td><label for="adminemail">{L('fromaddress')}</label></td>
          <td>
            <input id="adminemail" name="admin_email" class="text" type="text" size="40" maxlength="100" value="{$fs->prefs['admin_email']}" />
          </td>
        </tr>
        <tr>
          <td><label for="smtpserv">{L('smtpserver')}</label></td>
          <td>
            <input id="smtpserv" name="smtp_server" class="text" type="text" size="40" maxlength="100" value="{$fs->prefs['smtp_server']}" />
          </td>
        </tr>
        <tr>
          <td><label for="smtpuser">{L('smtpuser')}</label></td>
          <td>
            <input id="smtpuser" name="smtp_user" class="text" type="text" size="40" maxlength="100" value="{$fs->prefs['smtp_user']}" />
          </td>
        </tr>
        <tr>
          <td><label for="smtppass">{L('smtppass')}</label></td>
          <td>
            <input id="smtppass" name="smtp_pass" class="text" type="text" size="40" maxlength="100" value="{$fs->prefs['smtp_pass']}" />
          </td>
        </tr>
        <tr>
          <th colspan="2"><hr />
            {L('jabbernotify')}
          </th>
        </tr>
        <tr>
          <td><label for="jabberserver">{L('jabberserver')}</label></td>
          <td>
            <input id="jabberserver" class="text" type="text" name="jabber_server" size="40" maxlength="100" value="{$fs->prefs['jabber_server']}" />
          </td>
        </tr>
        <tr>
          <td><label for="jabberport">{L('jabberport')}</label></td>
          <td>
            <input id="jabberport" class="text" type="text" name="jabber_port" size="40" maxlength="100" value="{$fs->prefs['jabber_port']}" />
          </td>
        </tr>
        <tr>
          <td><label for="jabberusername">{L('jabberuser')}</label></td>
          <td>
            <input id="jabberusername" class="text" type="text" name="jabber_username" size="40" maxlength="100" value="{$fs->prefs['jabber_username']}" />
          </td>
        </tr>
        <tr>
          <td><label for="jabberpassword">{L('jabberpass')}</label></td>
          <td>
            <input id="jabberpassword" name="jabber_password" class="password" type="password" size="40" maxlength="100" value="{$fs->prefs['jabber_password']}" />
          </td>
        </tr>
      </table>
    </div>

    <div id="lookandfeel" class="tab">
      <table class="admin">
        <tr>
          <td><label for="globaltheme">{L('globaltheme')}</label></td>
          <td>
            <select id="globaltheme" name="global_theme">
              {!tpl_options($fs->listThemes(), $fs->prefs['global_theme'], true)}
            </select>
          </td>
        </tr>
        <tr>
          <td><label id="viscollabel">{L('visiblecolumns')}</label></td>
          <td class="text">
            <?php // Set the selectable column names
            $columnnames = array('id', 'project', 'tasktype', 'category', 'severity',
            'priority', 'summary', 'dateopened', 'status', 'openedby',
            'assignedto', 'lastedit', 'reportedin', 'dueversion', 'duedate',
            'comments', 'attachments', 'progress', 'dateclosed', 'os', 'votes');
            $selectedcolumns = explode(" ", $fs->prefs['visible_columns']);
            ?>
            {!tpl_double_select('visible_columns', $columnnames, $selectedcolumns, true)}
          </td>
        </tr>
      </table>
    </div>

    <div class="tbuttons">
      <input type="hidden" name="do" value="modify" />
      <input type="hidden" name="action" value="globaloptions" />
      <input type="hidden" name="prev_page" value="{$_SERVER['REQUEST_URI']}" />
      <button type="submit">{L('saveoptions')}</button>

      <button type="reset">{L('resetoptions')}</button>
    </div>

  </form>

</div>
