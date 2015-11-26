Shindo.tests('Fog::Compute[:xenserver] | create_vif request', ['xenserver']) do

  compute = Fog::Compute[:xenserver]
  servers = compute.servers
  # pre-flight cleanup
  (servers.all :name_matches => test_ephemeral_vm_name).each do |s|
    s.destroy
  end

  tests('create_vif should') do
    vm_ref = compute.create_server test_ephemeral_vm_name, test_template_name
    ref = compute.create_vif vm_ref, compute.networks.first.reference
    s = servers.get vm_ref
    test('return a valid reference') do
      if (ref != "OpaqueRef:NULL") and (ref.split("1") != "NULL")
        true
      else
        false
      end
    end
    test('add the VIF to the server') do
      !(s.vifs.find { |vif| vif.reference == ref }).nil?
    end
    raises(ArgumentError, 'raise ArgumentError when vm_ref nil') do
      ref = compute.create_vif nil, compute.networks.first.reference
    end
    raises(ArgumentError, 'raise ArgumentError when network_ref nil') do
      ref = compute.create_vif vm_ref, nil
    end
    test('create a VIF with device number 9') do
      ref = compute.create_vif vm_ref, compute.networks.first.reference, 9
      s.reload
      (compute.vifs.get(ref).device == 9.to_s) and \
        !(s.vifs.find { |vif| vif.reference == ref }).nil?
    end
  end

  tests('create_vif_custom should') do
    vm_ref = compute.create_server test_ephemeral_vm_name, test_template_name
    network_ref = compute.networks.first.reference
    conf = {
      'MAC_autogenerated' => 'True',
      'VM' => vm_ref,
      'network' => network_ref,
      'MAC' => '',
      'device' => '4',
      'MTU' => '0',
      'other_config' => {},
      'qos_algorithm_type' => 'ratelimit',
      'qos_algorithm_params' => {}
    }
    ref = compute.create_vif_custom conf
    s = servers.get vm_ref
    test('return a valid reference') do
      if (ref != "OpaqueRef:NULL") and (ref.split("1") != "NULL")
        true
      else
        false
      end
    end
    test('add the VIF to the server') do
      !(s.vifs.find { |vif| vif.reference == ref }).nil?
    end
    raises(ArgumentError, 'raise ArgumentError when conf is not a Hash') do
      conf['device'] = '5'
      ref = compute.create_vif_custom 'foobar'
    end
    test('create a VIF with device number 9') do
      conf['device'] = '9'
      ref = compute.create_vif_custom conf
      s.reload
      (compute.vifs.get(ref).device == 9.to_s) and \
        !(s.vifs.find { |vif| vif.reference == ref }).nil?
    end
    test('create a VIF with MAC 11:22:33:44:55:66') do
      conf['MAC_autogenerated'] = 'False'
      conf['MAC'] = '11:22:33:44:55:66'
      conf['device'] = '6'
      ref = compute.create_vif_custom conf
      vif = compute.vifs.get ref
      vif.mac == '11:22:33:44:55:66'
    end
  end

  tests('The expected options') do
    raises(ArgumentError, 'raises ArgumentError when vm_ref,net_ref missing') { compute.create_vif }
  end
end
