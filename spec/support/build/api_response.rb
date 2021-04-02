# frozen_string_literal: true

module Build
  module ApiResponse
    def self.info(parameters = {})
      {
        version: '6.7.2',
        worker_version: '2.2',
        external_url: 'https://ci.example.com',
        cluster_name: 'CI Cluster'
      }.merge(parameters)
    end

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Naming/VariableNumber
    def self.token_pre_version_6_1(parameters = {})
      {
        access_token:
            'eyJhbGciOiJSUzI1NiIsImtpZCI6IiIsInR5cCI6IkpXVCJ9.eyJjc3JmIjoi' \
              'YzQ5NTQwYTYwMjI0Yjk4MDAwMDgwYzNhZjlkZDI2MjE4OTNlYjgwMWMzZ' \
              'GEyYWMzOGJhNWEwZWM1ZmE1ZTJhYyIsImVtYWlsIjoiYWRtaW5pc3RyYX' \
              'RvciIsImV4cCI6MTUzNjUyOTA3NSwiaXNfYWRtaW4iOnRydWUsIm5hbWU' \
              'iOiIiLCJzdWIiOiJDZzFoWkcxcGJtbHpkSEpoZEc5eUVnVnNiMk5oYkEi' \
              'LCJ0ZWFtcyI6WyJtYWluIl0sInVzZXJfaWQiOiJhZG1pbmlzdHJhdG9yI' \
              'iwidXNlcl9uYW1lIjoiYWRtaW5pc3RyYXRvciJ9.E3eo7uuqhp3r9NKHp' \
              'vdajTqVbEZAMUh1mvbLieuY3Uck51TbMHhmSoPgaa6sRUoNfMwOs2Vv3U' \
              'R6dsa69ZoQn4zGcOtQys-KSA54OBUfxOS32yp8sCCaX3N7-KBot4hZZY9' \
              'MmVIJ0F2a9dDjAqUtJwCCmrLJJBily7SbYeL9yni3aj8HkCIH9skqVpeL' \
              'iemNcMc3rcHfHg8GLrwyEg2HRaSomSwjN_5nWxpYPTBkQW9eZz1rN5i1z' \
              'pgn4iNmY5d084Ommlf9iBUiQgtSvBOeasoW2YZe4ZYzT7ovAQo1sW0uVo' \
              'bk8WRCZaGaUh75pjjf6f-_kJ7wOqX-tSaOSysHNxZM91GVm5hcFOz2W3m' \
              '54acs7SrA6LS9biPWD5z0U24-0Tk2_GxD8yzIWWcYYNyd61F2vuEANGGp' \
              'CTJo58uwTLeGOx8hIqUQH-RYv6usqFbkkfU8-7rcNZ6TgCjbBjFAqySiH' \
              '0YEk_boe6GNCw-T4Khg8nHlQq-FowS8TRlibOq9wdI_7D-aEXDM23yN1j' \
              'Bkt4N4_WP9kC8_l5-FKzVYmi-w_M3FX6rDp5Dbfyi2hKcLcg8eBO6hIwC' \
              '6MkNcerhl76Y4FhfgpHcFXqJWDwjsKR6abQqGRh9d446VmB3CP86OM03i' \
              'iZf0qQV4pAxBwHgi7DbZRlK1ak3Up4x9eB_VzCc',
        token_type: 'Bearer',
        expiry: '2021-09-08T22:37:55.973Z'
      }.merge(parameters)
    end
    # rubocop:enable Naming/VariableNumber
    # rubocop:enable Metrics/MethodLength

    # rubocop:disable Metrics/MethodLength
    def self.token_current(parameters = {})
      {
        access_token: 'V19DzKfiMFWut5UIa4TfDjXSo9DBXOdfAAAAAA',
        token_type: 'bearer',
        expires_in: 86_400,
        id_token:
              'eyJhbGciOiJSUzI1NiIsImtpZCI6ImFjYjc5NjcxMmZlODM0MTQ4NjY3M2FkN' \
                'WYwZjkwYjRiM2Q2YTZhODAifQ.eyJpc3MiOiJodHRwczovL2NpLXNlcnZ' \
                'lci5yZG0tbWFuYWdlbWVudC5yZWRlZW1ldW0uaW8vc2t5L2lzc3VlciIs' \
                'InN1YiI6IkNnMWhaRzFwYm1semRISmhkRzl5RWdWc2IyTmhiQSIsImF1Z' \
                'CI6ImZseSIsImV4cCI6MTYwODk5ODA4MSwiaWF0IjoxNjA4OTExNjgxLC' \
                'JhdF9oYXNoIjoiSEZYc2ZKQjQwUm9ILWI3Q3NfV3lIUSIsImVtYWlsIjo' \
                'iYWRtaW5pc3RyYXRvciIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJmZWRl' \
                'cmF0ZWRfY2xhaW1zIjp7ImNvbm5lY3Rvcl9pZCI6ImxvY2FsIiwidXNlc' \
                'l9pZCI6ImFkbWluaXN0cmF0b3IiLCJ1c2VyX25hbWUiOiJhZG1pbmlzdH' \
                'JhdG9yIn19.cQJlL6z-r-FQp2d5InWVjDdNJPMnFAGtpaDULh9GQdbJKC' \
                '_udwvsdpVNsD1veM5D7CtTWB-8KuKg33k1S-oa1W9c-YBWBMldrgjYuca' \
                '51bA2KCX4wFgftuxctoBTWkZgcT7qvTzcwyfDRK9uYSQGDcJlLgKnCTDg' \
                'FYN-edDr_SfKeQL9OWFHrb6cKLcWA90ApqeZP-0470R2hv0D4ibd3mJLY' \
                'fS9dAJFFApbJ_sbEp6EjNvkcgy-eIy3KnX2uvWd7CT8Bw8Qw9yARkOfqO' \
                'Mv-g7rpR5gyroUv_3pBjESfXzhGYxiVTg0o4rJG-jTybEZLDouCodYfKg' \
                'laNtwXBo1EZZzHiZrmV-V2ZhHGLMy7vg9oUIv4HrTmXf5wXvZZGK8Z8if' \
                'voNoXAzgAaD71ejuLx_VGh5sv-YBV55TCNZn6bpyF-cbycAN8IGqCa4Xb' \
                'l7uS1AolKqIO1f0X86K_zlU0VZwERD5FuRnGGoyCk-3ZQDZJDTs-paNol' \
                '29NsbLG7j3sy6tvUsssqinxVt7-N85pc3nQQPmt4y7zQer1rSof1e_zLI' \
                '3X3x4FWt6j94v--vZIWwPOyUIe9uXY_FQr_BwUC630eo8d6UFYRry3apk' \
                'JBrcm_sAJbv-peSBnp-Du7_gGBzytBuJpxDPJHRU5EbxASG4dVVr3JEgi' \
                'BnqcnwRoO8'
      }.merge(parameters)
    end
    # rubocop:enable Metrics/MethodLength
  end
end
