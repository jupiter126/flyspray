<fieldset class="admin">
  <form action="{$baseurl}" method="post">
    <table class="admin">
      <tr>
        <td><label for="realname">{L('realname')}</label></td>
        <td>
          <input id="realname" class="text" type="text" name="real_name" size="50" maxlength="100"
            value="{$user->infos['real_name']}" />
        </td>
      </tr>
      <tr>
        <td><label for="emailaddress">{L('emailaddress')}</label></td>
        <td>
          <input id="emailaddress" class="text" type="text" name="email_address" size="50" maxlength="100"
            value="{$user->infos['email_address']}" />
        </td>
      </tr>
      <tr>
        <td><label for="jabberid">{L('jabberid')}</label></td>
        <td>
          <input id="jabberid" class="text" type="text" name="jabber_id" size="50" maxlength="100"
            value="{$user->infos['jabber_id']}" />
        </td>
      </tr>
      <tr>
        <td><label for="notifytype">{L('notifytype')}</label></td>
        <td>
          <?php if ($fs->prefs['user_notify'] == '1'): ?>
          <select id="notifytype" name="notify_type">
            {!tpl_options(array(L('none'),
                                L('email'),
                                L('jabber'),
                                L('both')),
                                $user->infos['notify_type'])}
          </select>
          <?php else: ?>
          {L('setglobally')}
          <?php endif; ?>
          {!tpl_checkbox('notify_own', $user->infos['notify_own'], 'notify_own')}
          <label class="left notable" for="notify_own">{L('notifyown')}</label>
        </td>
      </tr>
      <tr>
        <td><label for="dateformat">{L('dateformat')}</label></td>
        <td>
          <input id="dateformat" class="text" name="dateformat" type="text" size="40" maxlength="30"
            value="{$user->infos['dateformat']}" />
        </td>
      </tr>
      <tr>
        <td><label for="dateformat_extended">{L('dateformat_extended')}</label></td>
        <td>
          <input id="dateformat_extended" class="text" name="dateformat_extended" type="text"
            size="40" maxlength="30" value="{$user->infos['dateformat_extended']}" />
        </td>
      </tr>
      <tr>
        <td><label for="tasks_perpage">{L('tasksperpage')}</label></td>
        <td>
          <select name="tasks_perpage" id="tasks_perpage">
            {!tpl_options(array(10, 25, 50, 100, 250), $user->infos['tasks_perpage'], true)}
          </select>
        </td>
      </tr>
      <?php if ($user->perms['is_admin']): ?>
      <tr>
        <td><label for="accountenabled">{L('accountenabled')}</label></td>
        <td>{!tpl_checkbox('account_enabled', $user->infos['account_enabled'], 'accountenabled')}</td>
      </tr>
      <tr>
        <td><label for="groupin">{L('globalgroup')}</label></td>
        <td>
          <select id="groupin" class="adminlist" name="group_in">
            {!tpl_options($groups, $user->infos['global_group'])}
          </select>
          <input type="hidden" name="record_id" value="{$user->infos['global_record_id']}" />
        </td>
      </tr>
      <?php endif; ?>
      <tr>
        <td colspan="2"><hr /></td>
      </tr>
      <tr>
        <td><label for="changepass">{L('changepass')}</label></td>
        <td><input id="changepass" class="password" type="password" name="changepass" size="40" maxlength="100" /></td>
      </tr>
      <tr>
        <td><label for="confirmpass">{L('confirmpass')}</label></td>
        <td><input id="confirmpass" class="password" type="password" name="confirmpass" size="40" maxlength="100" /></td>
      </tr>
      <tr>
        <td colspan="2" class="buttons">
          <input type="hidden" name="do" value="modify" />
          <input type="hidden" name="action" value="edituser" />
          <input type="hidden" name="user_id" value="{$user->id}" />
          <input type="hidden" name="prev_page" value="{$_SERVER['REQUEST_URI']}" />
          <button type="submit">{L('updatedetails')}</button>
        </td>
      </tr>
    </table>
  </form>
</fieldset>
