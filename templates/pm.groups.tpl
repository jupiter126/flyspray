<div id="toolbox">
  <h3>{L('admintoolboxlong')} :: {L('usersandgroups')}</h3>
  <fieldset class="box">
    <legend>{L('usersandgroups')}</legend>
    <form action="{$_SERVER['SCRIPT_NAME']}" method="post">
    <p>{L('addormoveusers')} {!tpl_userselect('uid')}
       {L('to')} <select name="user_to_group">
          {!tpl_options(Flyspray::listGroups($proj->id))}
          <option value="0">{L('nogroup')}</option>
          </select>
       <input type="hidden" name="do" value="pm" />
       <input type="hidden" name="area" value="groups" />
       <input type="hidden" name="action" value="pm.addusertogroup" />
       <button type="submit">OK</button>
    </p>
    </form>

    <p>
      <img src="{$this->get_image('kuser')}" alt="" class="middle" /> <a href="{CreateURL('pm', 'newgroup', $proj->id)}">{L('newgroup')}</a>
    </p>

    <table class="userlist">
      <caption>{L('currentgroups')} ({count($groups)})</caption>
      <colgroup>
        <col width="3*" />
        <col width="*" />
      </colgroup>
      <thead>
        <tr><th>{L('groupname')}</th><th>{L('users')}</th></tr>
      </thead>
      <?php foreach ($groups as $group): ?>
      <tr>
        <td><a href="{CreateUrl('editgroup', $group['group_id'], 'pm')}">{$group['group_name']}</a>
        <?php if ($group['group_desc'] != ''): ?>
        <br />
        <small>{$group['group_desc']}</small>
        <?php endif; ?>
        </td>
        <td><a href="{CreateURL('pm', 'users', null, array('group_id[]' => $group['group_id']))}">{$group['num_users']} {L('users')}</a></td>
      </tr>
    <?php endforeach; ?>
    </table>

    </div>
  </fieldset>
</div>
