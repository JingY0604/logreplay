package com.sogou.map.logreplay.security;

import java.util.List;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.util.SimpleByteSource;

import com.sogou.map.logreplay.bean.Permission;
import com.sogou.map.logreplay.bean.Role;
import com.sogou.map.logreplay.bean.User;
import com.sogou.map.logreplay.bean.UserWithRoles;
import com.sogou.map.logreplay.service.PermissionService;
import com.sogou.map.logreplay.service.UserService;

public class ShiroDbRealm extends AuthorizingRealm {
	
	private UserService userService;
	
	private PermissionService permissionService;
	
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	public void setPermissionService(PermissionService permissionService) {
		this.permissionService = permissionService;
	}
	
	/* spring��ͨ�������setCredentialsMatcherע��credentialsMatcher���� */
	
	/**
	 * ��֤�ص�����,��¼ʱ����.
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {
		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
		User user = userService.getUserByUsername(token.getUsername());
		if (user == null || !Boolean.TRUE.equals(user.getEnabled())) {
			return null;
		}
		SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(user.getUsername(), user.getPassword(), getName());
		info.setCredentialsSalt(new SimpleByteSource(user.getUsername()));
		SimplePrincipalCollection principals = (SimplePrincipalCollection) info.getPrincipals();
		principals.add(user, getName());
		return info;
	}

	/**
	 * ��Ȩ��ѯ�ص�����, ���м�Ȩ�����������û���Ȩ��Ϣʱ����.
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		User user = principals.oneByType(User.class);
		if(user != null) {
			UserWithRoles userWithRoles = userService.getUserWithRolesById(user.getId());
			for(Role role: userWithRoles.getRoles()) {
				info.addRole(role.getName());
				if(Role.ADMIN.equals(role.getName())) {
					info.addStringPermission("*:*");
				}
			}
			List<Permission> permissionList = permissionService.getPermissionListByRoleList(userWithRoles.getRoles());
			for(Permission permission: permissionList) {
				info.addStringPermission(permission.toString());
			}
		}
		return info;
	}
	
	/**
	 * ���˷����Ŀɼ�������Ϊpublic
	 * �˷����ڴ��������¿���ͨ��shiro�Ļ�������ȡ��ɫ��Ϣ
	 * �Ӷ����ٶ����ݿ������
	 */
	@Override
	public AuthorizationInfo getAuthorizationInfo(PrincipalCollection principals) {
		return super.getAuthorizationInfo(principals);
	}

}
