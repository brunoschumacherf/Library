module Cryptography
  def self.encrypt_pass(pass)
    key = 'e2kS14JoJCPJMlxJ'
    iv = 'adkjAususa89aKAk'
    aes = OpenSSL::Cipher::Cipher.new("aes-128-ctr" )
    aes.encrypt
    aes.key = key
    aes.iv = iv if iv != nil
    Base64.encode64(aes.update(pass) + aes.final).gsub("\n", "")
  end


  def self.decrypt_pass(pass)
    key = 'e2kS14JoJCPJMlxJ'
    iv = 'adkjAususa89aKAk'
    pass = Base64.decode64(pass.to_s.strip)
    aes = OpenSSL::Cipher::Cipher.new("aes-128-ctr" )
    aes.decrypt
    aes.key = key
    aes.iv = iv if iv != nil
    aes.update(pass) + aes.final
  end
end